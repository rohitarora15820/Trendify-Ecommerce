import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/model/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  // Variables
final _db=FirebaseFirestore.instance;

// Get all the orders related to User
Future<List<OrderModel>> fetchUserOrders()async{
  try{
final userId=AuthenticationRepository.instance.currentAuthenticatedUser!.uid;
if(userId.isEmpty) throw "Unable to find user information. Try again in few minutes.";

final result=await _db.collection('Users').doc(userId).collection('Orders').get();
// log(result.docs.map((e) => e.data()).toString());
return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
  }catch (e){
    log(e.toString());
    throw "Something went wrong while fetching user orders";
  }
}

// Store new user order
Future<void> saveUserOrder(OrderModel order,String userId)async{
try{
await _db.collection('Users').doc(userId).collection('Orders').add(order.toMap());
}catch (e){
  throw "Something went wrong while saving orders!";
}
}
}