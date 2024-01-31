import 'package:get/get.dart';
import 'package:haatinhandseller/screens/shop_details/model/shop_model.dart';

class ShopController extends GetxController {
  RxBool hasShop = false.obs;
  Rx<ShopModel> shop = ShopModel().obs;

  setShop(ShopModel s) {
    shop.value = s;
    hasShop.value = true;
  }

  clear() {
    hasShop.value = false;
    shop.value = ShopModel();
  }
}
