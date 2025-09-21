import 'package:flutter/material.dart';
import 'package:mobile/Components/Colors.dart';
import 'package:mobile/Pages/new.dart';

import '../Components/ElevationButton.dart';
import 'Home_Screen.dart';

class Work_Center extends StatefulWidget {
  const Work_Center({super.key});

  @override
  State<Work_Center> createState() => _Work_CenterState();
}

class _Work_CenterState extends State<Work_Center> {
  // Table data
  List<Map<String, String>> centres = [
    {"centre": "Work Centre - 1", "like": "Yes", "cost": "500"},
    {"centre": "Work Centre - 2", "like": "No", "cost": "700"},
  ];

  List<Map<String, String>> searchResults = [];

  // ===== SEARCH FUNCTION =====
  void _searchCentre() {
    final centreController = TextEditingController();
    final likeController = TextEditingController();
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Search Work"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: centreController,
                  decoration: const InputDecoration(labelText: "Enter Work"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    searchResults =
                        centres.where((item) {
                          final centreMatch =
                              centreController.text.isEmpty ||
                              item["centre"]!.toLowerCase().contains(
                                centreController.text.toLowerCase(),
                              );
                          final costMatch =
                              costController.text.isEmpty ||
                              item["cost"]!.contains(costController.text);
                          return centreMatch && costMatch;
                        }).toList();
                  });
                  Navigator.pop(context);
                },
                child: const Text("Search"),
              ),
            ],
          ),
    );
  }

  // ===== ADD FUNCTION =====
  void addRow() {
    final centreController = TextEditingController();
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: 350,
          width: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.c1,AppTheme.c2], // 🌈 your gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Create New Centre",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // make visible on gradient
                ),
              ),
              const SizedBox(height: 60),
              TextField(
                controller: centreController,
                decoration: InputDecoration(
                  labelText: "Work Centre",
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 22),
              TextField(
                controller: costController,
                decoration: InputDecoration(
                  labelText: "Cost Per Hour",
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 75),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        centres.add({
                          "centre": centreController.text,
                          "cost": costController.text,
                        });
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Create"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ===== EDIT FUNCTION =====
  void _editRow(int index) {
    final centreController = TextEditingController(
      text: centres[index]["centre"],
    );
    final costController = TextEditingController(text: centres[index]["cost"]);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Edit Centre"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: centreController,
                  decoration: const InputDecoration(labelText: "Work Centre"),
                ),
                TextField(
                  controller: costController,
                  decoration: const InputDecoration(labelText: "Cost Per Hour"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    centres[index]["centre"] = centreController.text;
                    centres[index]["cost"] = costController.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  // ===== DELETE FUNCTION =====
  void _deleteRow(int index) {
    setState(() {
      centres.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayList = searchResults.isNotEmpty ? searchResults : centres;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.white70),
                //   borderRadius: BorderRadius.circular(8),
                //   gradient: LinearGradient(
                //     colors: [AppTheme.c2, AppTheme.c1],
                //   ),
                // ),
                child: GradientElevatedButton(text: "NEW", onPressed: addRow)
              ),
              const SizedBox(width: 20),
              ResponsiveSearchField(),

              const SizedBox(width: 20),
              Row(
                children: [
                  IconButton.outlined(
                    iconSize: 20,
                    onPressed: () {},
                    tooltip: "Add Rows",
                    icon: const Icon(Icons.table_rows),
                  ),
                  const SizedBox(width: 10),
                  IconButton.outlined(
                    iconSize: 20,
                    onPressed: () {},
                    tooltip: "Add Rows",
                    icon: const Icon(Icons.table_rows),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 1350,
            child: DataTable(
              border: TableBorder.all(color: Colors.grey),
              columns: const [
                DataColumn(label: Text("Work Centre")),
                DataColumn(label: Text("Cost Per Hour")),
                DataColumn(label: Text("Actions")),
              ],
              rows: List.generate(displayList.length, (index) {
                final item = displayList[index];
                return DataRow(
                  cells: [
                    DataCell(Text(item["centre"]!)),
                    DataCell(Text(item["cost"]!)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editRow(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteRow(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        )

      ],
    );
  }
}

