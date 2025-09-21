import 'dart:async';
import 'package:flutter/material.dart';


class WorkOrderAnalyticsPage extends StatefulWidget {
  const WorkOrderAnalyticsPage({super.key});

  @override
  State<WorkOrderAnalyticsPage> createState() =>
      _WorkOrderAnalyticsPageState();
}

class _WorkOrderAnalyticsPageState extends State<WorkOrderAnalyticsPage> {
  List<Map<String, dynamic>> workOrders = [
    {
      "operation": "Assembly-1",
      "workCenter": "Work Center-1",
      "product": "Dining Table",
      "quantity": "3",
      "expectedDuration": 180, // in minutes
      "realDuration": 0, // seconds
      "status": "To Do",
      "isRunning": false,
      "timerObj": null
    }
  ];

  List<Map<String, dynamic>> filteredWorkOrders = [];

  @override
  void initState() {
    super.initState();
    filteredWorkOrders = List.from(workOrders);
  }

  // ---------------- Search Function ----------------
  void _searchWorkOrder() {
    final searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Search Work Order"),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: "Enter Operation or Product",
          ),
          autofocus: true,
          onSubmitted: (value) {
            _executeSearch(value);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _executeSearch(String query) {
    setState(() {
      filteredWorkOrders = workOrders.where((item) {
        return item["operation"]
            .toLowerCase()
            .contains(query.toLowerCase()) ||
            item["product"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });

    if (filteredWorkOrders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No work order found"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // ---------------- Timer Functions ----------------
  void _startTimer(int index) {
    if (workOrders[index]["timerObj"] != null) return;

    workOrders[index]["timerObj"] = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          workOrders[index]["realDuration"] += 1;
        });
      },
    );
    workOrders[index]["isRunning"] = true;
  }

  void _pauseTimer(int index) {
    workOrders[index]["timerObj"]?.cancel();
    workOrders[index]["timerObj"] = null;
    workOrders[index]["isRunning"] = false;
    setState(() {});
  }

  void _resetTimer(int index) {
    _pauseTimer(index);
    workOrders[index]["realDuration"] = 0;
    setState(() {});
  }

  String _formatDuration(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  double getTotalExpectedDuration() {
    return workOrders.fold(
        0, (sum, item) => sum + (item["expectedDuration"] ?? 0));
  }

  double getTotalRealDuration() {
    return workOrders.fold(0, (sum, item) => sum + (item["realDuration"] ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Order Analytics"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchWorkOrder,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DataTable(
                border: TableBorder.all(color: Colors.grey),
                columns: const [
                  DataColumn(label: Text("Operation")),
                  DataColumn(label: Text("Work Center")),
                  DataColumn(label: Text("Product")),
                  DataColumn(label: Text("Quantity")),
                  DataColumn(label: Text("Expected Duration")),
                  DataColumn(label: Text("Real Duration")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: List.generate(filteredWorkOrders.length, (index) {
                  final item = filteredWorkOrders[index];
                  final realController = TextEditingController(
                      text: _formatDuration(item["realDuration"]));

                  return DataRow(cells: [
                    DataCell(Text(item["operation"])),
                    DataCell(Text(item["workCenter"])),
                    DataCell(TextField(
                      controller:
                      TextEditingController(text: item["product"]),
                      decoration: const InputDecoration(border: InputBorder.none),
                      onSubmitted: (value) {
                        setState(() {
                          filteredWorkOrders[index]["product"] = value;
                        });
                      },
                    )),
                    DataCell(TextField(
                      controller:
                      TextEditingController(text: item["quantity"].toString()),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(border: InputBorder.none),
                      onSubmitted: (value) {
                        setState(() {
                          filteredWorkOrders[index]["quantity"] = value;
                        });
                      },
                    )),
                    DataCell(Text(item["expectedDuration"].toString())),
                    DataCell(Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: realController,
                            decoration: const InputDecoration(border: InputBorder.none),
                            onSubmitted: (value) {
                              // convert hh:mm:ss to seconds
                              final parts = value.split(':');
                              int seconds = 0;
                              if (parts.length == 3) {
                                seconds = int.parse(parts[0]) * 3600 +
                                    int.parse(parts[1]) * 60 +
                                    int.parse(parts[2]);
                              }
                              setState(() {
                                filteredWorkOrders[index]["realDuration"] = seconds;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(item["isRunning"]
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () {
                            if (item["isRunning"]) {
                              _pauseTimer(index);
                            } else {
                              _startTimer(index);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.restart_alt),
                          onPressed: () => _resetTimer(index),
                        ),
                      ],
                    )),
                    DataCell(DropdownButton<String>(
                      value: item["status"],
                      items: ["To Do", "In Progress", "Done"]
                          .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          filteredWorkOrders[index]["status"] = value;
                        });
                      },
                    )),
                    DataCell(IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          workOrders.removeAt(index);
                        });
                      },
                    )),
                  ]);
                }),
              ),
              const SizedBox(height: 20),
              Text(
                "Total Expected Duration: ${getTotalExpectedDuration()} mins",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Total Real Duration: ${_formatDuration(getTotalRealDuration() as int)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}