import 'package:flutter/material.dart';
import '../Components/Colors.dart';
import '../Components/ElevationButton.dart';
import '../models/moModels.dart';
import '../services/apiServices.dart';

class ManufacturingOrderPage extends StatefulWidget {
  const ManufacturingOrderPage({super.key});

  @override
  State<ManufacturingOrderPage> createState() => _ManufacturingOrderPageState();
}

class _ManufacturingOrderPageState extends State<ManufacturingOrderPage> {
  String selectedStatus = "planned";
  final ApiService apiService = ApiService();
  late Future<List<ManufacturingOrder>> futureOrders;

  // Controllers for new order
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController assigneeController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController statesController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController statusController = TextEditingController(text: "planned");

  @override
  void initState() {
    super.initState();
    futureOrders = apiService.fetchOrders();
  }

  void _setStatus(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  Widget _statusButton(String label) {
    bool isSelected = selectedStatus == label;
    return Container(
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(colors: [AppTheme.c2, AppTheme.c1])
            : LinearGradient(colors: [Colors.transparent, Colors.transparent]),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton(
        onPressed: () => _setStatus(label),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, String? label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  // Create New Order
  void _createOrder() async {
    try {
      final newOrder = ManufacturingOrder(
        id: 0, // backend will assign
        productId: int.tryParse(productController.text) ?? 0,
        orderQuantity: int.tryParse(quantityController.text) ?? 0,
        status: selectedStatus,
        units: unitsController.text,
        states: statesController.text,
        dueDate: dueDateController.text,
        createdBy: int.tryParse(assigneeController.text) ?? 0,
        createdAt: DateTime.now().toIso8601String(),
      );

      await apiService.updateOrder(newOrder);

      // Clear inputs
      productController.clear();
      quantityController.clear();
      assigneeController.clear();
      unitsController.clear();
      statesController.clear();
      dueDateController.clear();

      // Refresh list
      setState(() {
        futureOrders = apiService.fetchOrders();
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Order created successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error creating order: $e")));
    }
  }

  Widget _orderRow(ManufacturingOrder order) {
    final statusController = TextEditingController(text: order.status ?? "");
    final dueController = TextEditingController(text: order.dueDate ?? "");
    final unitsController = TextEditingController(text: order.units ?? "");
    final statesController = TextEditingController(text: order.states ?? "");

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order #${order.id} | Product: ${order.productId}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.save, color: Colors.green),
                  onPressed: () async {
                    order.status = statusController.text;
                    order.dueDate = dueController.text;
                    order.units = unitsController.text;
                    order.states = statesController.text;

                    await apiService.updateOrder(order);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Order updated")));
                    setState(() {
                      futureOrders = apiService.fetchOrders();
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 8),
            // Editable fields
            Row(
              children: [
                Expanded(child: _buildTextField(controller: statusController, label: "Status")),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField(controller: dueController, label: "Due Date")),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField(controller: unitsController, label: "Units")),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField(controller: statesController, label: "States")),
              ],
            ),
            const SizedBox(height: 12),
            // Work Orders
            const Text("Work Orders", style: TextStyle(fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(color: Colors.grey),
                columns: const [
                  DataColumn(label: Text("Order Quantity")),
                  DataColumn(label: Text("Status")),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(order.orderQuantity.toString())),
                    DataCell(Text(order.status ?? "-")),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _statusButton("Planned"),
              const SizedBox(width: 8),
              _statusButton("cancelled"),
              _statusButton("In-Progress"),
              // _statusButton("To Close"),
              _statusButton("completed"),
            ],
          ),
          const SizedBox(height: 20),

          // Create New Order Form
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Create New Manufacturing Order", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(controller: productController, label: "Finish Product")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField(controller: quantityController, label: "Quantity")),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(controller: assigneeController, label: "Assignee")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField(controller: unitsController, label: "Units")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField(controller: statesController, label: "States")),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(controller: dueDateController, label: "Due Date"),
                  const SizedBox(height: 12),
                  GradientElevatedButton(
                      text: "Create Order",
                      onPressed: _createOrder),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Existing Orders List
          FutureBuilder<List<ManufacturingOrder>>(
            future: futureOrders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No orders found"));
              } else {
                final orders = snapshot.data!
                    .where((o) => (o.status ?? "").toLowerCase() == selectedStatus.toLowerCase())
                    .toList();
                if (orders.isEmpty) return const Center(child: Text("No orders for this status"));

                return Column(
                  children: orders.map((order) => _orderRow(order)).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
