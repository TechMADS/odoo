class WorkOrder {
  int? id;
  int manufacturingOrderId;
  String taskName;
  int assignedTo;
  String status;
  String? startTime;
  String? endTime;

  WorkOrder({
    this.id,
    required this.manufacturingOrderId,
    required this.taskName,
    required this.assignedTo,
    required this.status,
    this.startTime,
    this.endTime,
  });

  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
    id: json['id'],
    manufacturingOrderId: json['manufacturing_order_id'],
    taskName: json['task_name'],
    assignedTo: json['assigned_to'],
    status: json['status'],
    startTime: json['start_time'],
    endTime: json['end_time'],
  );

  Map<String, dynamic> toJson() => {
    "manufacturing_order_id": manufacturingOrderId,
    "task_name": taskName,
    "assigned_to": assignedTo,
    "status": status,
    "start_time": startTime,
    "end_time": endTime,
  };
}
