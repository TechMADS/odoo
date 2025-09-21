import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/bom.dart';
import '../models/moModels.dart';
import '../models/wOrders.dart';

class ApiService {
  final String baseUrl = "http://10.69.176.80:5000/api"; // Emulator / PC IP

  Future<List<ManufacturingOrder>> fetchOrders() async {
    final response = await http.get(Uri.parse("$baseUrl/manufacturing-orders"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ManufacturingOrder.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load orders: ${response.statusCode}");
    }
  }

  Future<void> updateOrder(ManufacturingOrder order) async {
    final response = await http.post(
      Uri.parse("$baseUrl/manufacturing-orders"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to update order: ${response.statusCode}");
    }
  }

  // Fetch all work orders
  Future<List<WorkOrder>> fetchWorkOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/worker-orders'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => WorkOrder.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch work orders');
    }
  }

  // Create a new work order
  Future<WorkOrder> createWorkOrder(WorkOrder workOrder) async {
    final response = await http.post(
      Uri.parse('$baseUrl/worker-orders'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(workOrder.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return WorkOrder.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create work order: ${response.body}');
    }
  }

  // Update an existing work order
  Future<WorkOrder> updateWorkOrder(WorkOrder workOrder) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${workOrder.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(workOrder.toJson()),
    );

    if (response.statusCode == 200) {
      return WorkOrder.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update work order');
    }
  }

  // Fetch all BOMs
  Future<List<dynamic>> fetchBOMs() async {
    final response = await http.get(Uri.parse("$baseUrl/bom"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load BOMs");
    }
  }

  // Create new BOM
  static Future<Map<String, dynamic>> createBOM(
      int productId, int rawMaterialId, int quantity, String unit) async {
    final response = await http.post(
      Uri.parse("http://localhost:5000/bom"), // adjust your backend URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "product_id": productId,
        "raw_material_id": rawMaterialId,
        "quantity_required": quantity,
        "unit": unit,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create BOM: ${response.body}");
    }
  }

  // Delete BOM by ID
  Future<void> deleteBOM(int id) async {
    final response =
    await http.delete(Uri.parse("$baseUrl/bill_of_materials/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete BOM");
    }
  }
}
