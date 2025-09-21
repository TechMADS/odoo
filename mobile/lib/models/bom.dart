class BOM {
  final int id;
  final int productId;
  final int rawMaterialId;
  final double quantityRequired;
  final String unit;

  BOM({
    required this.id,
    required this.productId,
    required this.rawMaterialId,
    required this.quantityRequired,
    required this.unit,
  });

  factory BOM.fromJson(Map<String, dynamic> json) {
    return BOM(
      id: json['id'],
      productId: json['product_id'],
      rawMaterialId: json['raw_material_id'],
      quantityRequired: (json['quantity_required'] as num).toDouble(),
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "raw_material_id": rawMaterialId,
      "quantity_required": quantityRequired,
      "unit": unit,
    };
  }
}
