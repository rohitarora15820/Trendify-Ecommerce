import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tstore/features/shop/model/address_model.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';
import 'package:tstore/utils/http/http_client.dart';

import '../../../utils/constants/enums.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = "Paypal",
    this.address,
    this.deliveryDate,
    required this.items,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      deliveryDate != null ? THelperFunctions.getFormattedDate(orderDate) : "";

  String get orderStatusText => status == OrderStatus.delivered
      ? "Delivered"
      : status == OrderStatus.shipped
          ? "Shipped on the way"
          : "Processing";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': this.userId,
      'status': status.toString(),
      'totalAmount': this.totalAmount,
      'orderDate': this.orderDate,
      'paymentMethod': this.paymentMethod,
      'address': address?.toMap(),
      'deliveryDate': this.deliveryDate,
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      status:

      OrderStatus.values
          .firstWhere((element) => element.toString() == map["status"]),
      totalAmount: map['totalAmount'] as double,
      orderDate: (map['orderDate'] as Timestamp).toDate(),
      paymentMethod: map['paymentMethod'] as String,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      deliveryDate:  (map['deliveryDate'] as Timestamp).toDate(),
      items: (map['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
