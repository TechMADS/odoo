import 'dart:async';
import 'package:flutter/material.dart';
import '../models/wOrders.dart';
import '../services/apiServices.dart';

class WorkOrdersPage extends StatefulWidget {
  const WorkOrdersPage({super.key});

  @override
  State<WorkOrdersPage> createState() => _WorkOrdersPageState();
}

class _WorkOrdersPageState extends State<WorkOrdersPage> {
  final ApiService apiService = ApiService();
  late Future<List<WorkOrder>> futureWorkOrders;

  @override
  void initState() {
    super.initState();
    futureWorkOrders = apiService.fetchWorkOrders();
  }

  // Timer management
  Map<int, Timer?> timers = {};

  void _startTimer(int index, List<WorkOrder> orders) {
    if (timers[index] != null) return;
    int seconds = 0;

    timers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        orders[index].startTime = _formatDuration(seconds);
      });
    });
  }

  void _pauseTimer(int index) {
    timers[index]?.cancel();
    timers[index] = null;
  }

  void _resetTimer(int index, List<WorkOrder> orders) {
    _pauseTimer(index);
    orders[index].startTime = "00:00";
    setState(() {});
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _showNewWorkOrderForm(BuildContext context) {
    final _taskController = TextEditingController();
    final _assignedToController = TextEditingController();
    final _manuOrderIdController = TextEditingController();
    String _status = "pending";

    DateTime? _startDate;
    DateTime? _endDate;

    Future<void> _pickDate(BuildContext context, bool isStart) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        setState(() {
          if (isStart) {
            _startDate = picked;
          } else {
            _endDate = picked;
          }
        });
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "New Work Order",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _manuOrderIdController,
                  keyboardType: TextInputType.number,
                  decoration:
                  const InputDecoration(labelText: "Manufacturing Order ID"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(labelText: "Task Name"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _assignedToController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Assigned To (User ID)"),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(labelText: "Status"),
                  items: ["pending", "in_progress", "done"]
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
                      .toList(),
                  onChanged: (value) {
                    _status = value!;
                  },
                ),
                const SizedBox(height: 8),
                // Start Date Picker
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Start Date: ${_startDate != null ? _startDate!.toIso8601String().split('T').first : "-"}"),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, true),
                      child: const Text("Pick Start Date"),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                // End Date Picker
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "End Date: ${_endDate != null ? _endDate!.toIso8601String().split('T').first : "-"}"),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, false),
                      child: const Text("Pick End Date"),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    try {
                      final newWorkOrder = WorkOrder(
                        manufacturingOrderId:
                        int.parse(_manuOrderIdController.text),
                        taskName: _taskController.text,
                        assignedTo: int.parse(_assignedToController.text),
                        status: _status,
                        startTime: _startDate?.toIso8601String(),
                        endTime: _endDate?.toIso8601String(),
                      );

                      await apiService.createWorkOrder(newWorkOrder);

                      Navigator.pop(context);

                      setState(() {
                        futureWorkOrders = apiService.fetchWorkOrders();
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Work order created successfully")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkOrder>>(
      future: futureWorkOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No work orders found"));
        }

        final workOrders = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text("New Work Order"),
                  onPressed: () => _showNewWorkOrderForm(context),
                ),
              ),
              DataTable(
                border: TableBorder.all(color: Colors.grey),
                columns: const [
                  DataColumn(label: Text("Task")),
                  DataColumn(label: Text("Assigned To")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Start Time")),
                  DataColumn(label: Text("End Time")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: List.generate(workOrders.length, (index) {
                  final item = workOrders[index];
                  return DataRow(cells: [
                    DataCell(Text(item.taskName)),
                    DataCell(Text(item.assignedTo.toString())),
                    DataCell(
                      DropdownButton<String>(
                        value: item.status,
                        items: ["pending", "in_progress", "done"]
                            .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            item.status = value!;
                          });
                        },
                      ),
                    ),
                    DataCell(Text(item.startTime ?? "-")),
                    DataCell(Text(item.endTime ?? "-")),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () => _startTimer(index, workOrders),
                        ),
                        IconButton(
                          icon: const Icon(Icons.pause),
                          onPressed: () => _pauseTimer(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.restart_alt),
                          onPressed: () => _resetTimer(index, workOrders),
                        ),
                      ],
                    )),
                  ]);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}