import 'order_item_model.dart';

class OrderModel {
  final int id;
  final double total;
  final bool status;
  final DateTime dateOrdered;
  final bool isCancel;
  final List<OrderItemModel> orderItem;

  OrderModel({
    this.id = -1,
    required this.total,
    required this.status,
    required this.dateOrdered,
    required this.isCancel,
    required this.orderItem,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'total': total,
      'status': status,
      'dateOrdered': dateOrdered.toIso8601String(),
      'isCancel': isCancel,
      'orderItem': orderItem.map((x) => x.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      total: map['total'] as double,
      status: map['status'] as bool,
      dateOrdered: DateTime.parse(map['date_ordered'] as String),
      isCancel: map['is_cancel'] as bool,
      orderItem: List<OrderItemModel>.from(
        (map['order_item'] as List).map<OrderItemModel>(
          (x) => OrderItemModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
