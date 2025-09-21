class ManufacturingOrder {
  final int id;
  final int productId;
  final int orderQuantity;
  String status;
  final int createdBy;
  final String createdAt;
  String dueDate;
  String units;
  String states;

  ManufacturingOrder({
    required this.id,
    required this.productId,
    required this.orderQuantity,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.dueDate,
    required this.units,
    required this.states,
  });

  factory ManufacturingOrder.fromJson(Map<String, dynamic> json) {
    return ManufacturingOrder(
      id: json['id'],
      productId: json['product_id'],
      orderQuantity: json['order_quantity'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      dueDate: json['due_date'],
      units: json['units'] ?? 'N/A',
      states: json['states'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'order_quantity': orderQuantity,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt,
      'due_date': dueDate,
      'units': units,
      'states': states,
    };
  }
}
