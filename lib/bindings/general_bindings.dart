import 'package:get/get.dart';
import 'package:tstore/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
  }


}