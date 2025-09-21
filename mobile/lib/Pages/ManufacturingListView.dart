import 'package:flutter/material.dart';

import '../Components/Colors.dart';

class ManufacturingOrdersPage extends StatefulWidget {
  const ManufacturingOrdersPage({super.key});

  @override
  State<ManufacturingOrdersPage> createState() =>
      _ManufacturingOrdersPageState();
}

class _ManufacturingOrdersPageState extends State<ManufacturingOrdersPage> {
  // Example dataset (replace with API or DB later)
  final List<Map<String, String>> orders = [
    {
      "orderNo": "MO-1001",
      "product": "Washing Machine - Model X",
      "status": "In Progress",
      "scheduleDate": "20/09/2025"
    },
    {
      "orderNo": "MO-1002",
      "product": "Washing Machine - Model Y",
      "status": "Confirmed",
      "scheduleDate": "22/09/2025"
    },
    {
      "orderNo": "MO-1003",
      "product": "Washing Machine - Model Z",
      "status": "Draft",
      "scheduleDate": "25/09/2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manufacturing Orders", style: TextStyle(color: Colors.white),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.c2,AppTheme.c1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              title: Text(
                order["orderNo"] ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product: ${order["product"]}"),
                  Text("Schedule Date: ${order["scheduleDate"]}"),
                ],
              ),
              trailing: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(order["status"]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order["status"] ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// helper function to set status colors
  Color _getStatusColor(String? status) {
    switch (status) {
      case "Confirmed":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      case "Draft":
        return Colors.grey;
      case "Late":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
