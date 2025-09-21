import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/Card.dart';
import '../Components/Colors.dart';
import '../Components/ElevationButton.dart';
import '../models/moModels.dart';
import '../services/apiServices.dart';
import '../utils/data_file.dart';
import 'Home_Screen.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  final double width = 200;

  String? selectedSubcategory;
  int selectedIndex = 0;

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  late Future<List<ManufacturingOrder>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = ApiService().fetchOrders();
  }

  final List<Map<String, String>> orders = [
    {
      "reference": "AO-000001",
      "startDate": "Tomorrow",
      "product": "Dining Table",
      "status": "Not Available",
      "quantity": "5.00",
      "unit": "Units",
      "state": "Confirmed",
    },
    {
      "reference": "AO-000002",
      "startDate": "Yesterday",
      "product": "Drawer",
      "status": "Available",
      "quantity": "2.00",
      "unit": "Units",
      "state": "In-Progress",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 15),
                  GradientElevatedButton(text: "ALL", onPressed: () {}),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("2", "DRAFT"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("5", "CONFIRMED"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("1", "INPROGRESS"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("7", "IN CLOSE"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "NOT ASSIGNED"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "LATE"),
                    height: 100,
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientElevatedButton(text: "MY", onPressed: () {}),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "CONFIRMED"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "IN PROGRESS"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "TO CLOSE"),
                    height: 100,
                  ),
                  SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "LATE"),
                    height: 100,
                  ),SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "LATE"),
                    height: 100,
                  ),SizedBox(width: 15),
                  card(
                    columnrow: _buildCardContent("11", "LATE"),
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ================= Orders Table Section =================
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              // Header Row
              IntrinsicHeight(
                child: Row(
                  children: const [
                    SizedBox(width: 40, child: Text("")),
                    _HeaderCell("ID"),
                    _HeaderCell("Product ID"),
                    _HeaderCell("Quantity"),
                    _HeaderCell("Status"),
                    _HeaderCell("Units"),
                    _HeaderCell("States"),
                    _HeaderCell("Due Date"),
                  ],
                ),
              ),
              const Divider(thickness: 1),

              // Data Rows
              FutureBuilder<List<ManufacturingOrder>>(
                future: futureOrders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No orders available"),
                    );
                  }

                  final orders = snapshot.data!;
                  return Column(
                    children: orders.map((order) {
                      return Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Checkbox(
                                    value: false,
                                    onChanged: (_) {},
                                  ),
                                ),
                                _DataCell(order.id.toString()),
                                _DataCell(order.productId.toString()),
                                _DataCell(order.orderQuantity.toString()),
                                _DataCell(order.status ?? "-"),
                                _DataCell(order.units ?? "-"),
                                _DataCell(order.states ?? "-"),
                                _DataCell(order.dueDate?.toString() ?? "-"),
                                _DataCell(order.createdBy?.toString() ?? "-"),
                                _DataCell(order.createdAt?.toString() ?? "-"),
                              ],
                            ),
                          ),
                          const Divider(thickness: 1),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),

              // Empty rows for spacing
              ...List.generate(5, (index) {
                return Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Checkbox(value: false, onChanged: (_) {}),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent(String number, String label) {
    return Container(
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void fetchTableData(String department, String subcategory) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/data?dept=$department&sub=$subcategory'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> fetchedRows = jsonDecode(response.body);
      setState(() {
        GetData.rows = List<Map<String, dynamic>>.from(fetchedRows);
      });
    }
  }
}

// ================= Helper Cells =================
class _HeaderCell extends StatelessWidget {
  final String label;
  const _HeaderCell(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  const _DataCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text),
      ),
    );
  }
}
