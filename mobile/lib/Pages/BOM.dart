import 'package:flutter/material.dart';
import '../services/apiServices.dart';

class BOMPage extends StatefulWidget {
  const BOMPage({super.key});

  @override
  State<BOMPage> createState() => _BOMPageState();
}

class _BOMPageState extends State<BOMPage> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _fetchBOMs();
  }

  Future<void> _fetchBOMs() async {
    setState(() => _isLoading = true);
    try {
      final data = await _apiService.fetchBOMs(); // returns List<Map<String,dynamic>>
      setState(() => products = List<Map<String, dynamic>>.from(data));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching BOMs: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _deleteRow(int index) async {
    final id = products[index]['id'];
    try {
      await _apiService.deleteBOM(id);
      setState(() => products.removeAt(index));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 1350,
          child: DataTable(
            border: TableBorder.all(color: Colors.grey),
            columns: const [
              DataColumn(label: Text("Product Name")),
              DataColumn(label: Text("Product ID")),
              DataColumn(label: Text("Raw Material ID")),
              DataColumn(label: Text("Quantity")),
              DataColumn(label: Text("Unit")),
              DataColumn(label: Text("Actions")),
            ],
            rows: List.generate(products.length, (index) {
              final item = products[index];
              return DataRow(cells: [
                DataCell(Text(item['product_name'] ?? "-")),
                DataCell(Text(item['product_id'].toString())),
                DataCell(Text(item['raw_material_id'].toString())),
                DataCell(Text(item['quantity_required'].toString())),
                DataCell(Text(item['unit'] ?? "-")),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteRow(index),
                      ),
                    ],
                  ),
                ),
              ]);
            }),
          ),
        ),
      ),
       FloatingActionButton(
        onPressed: () {
          // Open add BOM dialog/page
        },
        child: const Icon(Icons.add),
      ),]
    );
  }
}
