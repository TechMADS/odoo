import 'package:flutter/material.dart';
import 'package:mobile/Components/Colors.dart';

class ManufacturingKanbanPage extends StatelessWidget {
  const ManufacturingKanbanPage({super.key});

  final List<Map<String, String>> orders = const [
    {
      "orderNo": "MO-1001",
      "product": "Washing Machine - Model X",
      "status": "In Progress",
      "scheduleDate": "20/09/2025"
    },{
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
    },{
      "orderNo": "MO-1002",
      "product": "Washing Machine - Model Y",
      "status": "Confirmed",
      "scheduleDate": "22/09/2025"
    },{
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
    {
      "orderNo": "MO-1004",
      "product": "Dryer Machine - Model A",
      "status": "Late",
      "scheduleDate": "18/09/2025"
    },{
      "orderNo": "MO-1004",
      "product": "Dryer Machine - Model A",
      "status": "Late",
      "scheduleDate": "18/09/2025"
    },{
      "orderNo": "MO-1004",
      "product": "Dryer Machine - Model A",
      "status": "Late",
      "scheduleDate": "18/09/2025"
    },{
      "orderNo": "MO-1004",
      "product": "Dryer Machine - Model A",
      "status": "Late",
      "scheduleDate": "18/09/2025"
    },{
      "orderNo": "MO-1004",
      "product": "Dryer Machine - Model A",
      "status": "Late",
      "scheduleDate": "18/09/2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Group orders by status
    final Map<String, List<Map<String, String>>> groupedOrders = {
      "Draft": [],
      "Confirmed": [],
      "In Progress": [],
      "Late": [],
    };

    for (var order in orders) {
      groupedOrders[order["status"] ?? "Draft"]?.add(order);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manufacturing Orders (Kanban)", style: TextStyle(color: Colors.white),),
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

      body: Row(
        children: groupedOrders.entries.map((entry) {
          return Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: _getStatusColor(entry.key),
                  child: Center(
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) {
                      final order = entry.value[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order["orderNo"] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(order["product"] ?? ""),
                              const SizedBox(height: 4),
                              Text("Schedule: ${order["scheduleDate"]}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getStatusColor(String status) {
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
