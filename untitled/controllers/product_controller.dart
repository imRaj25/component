import 'package:get/get.dart';
import 'package:haatinhandseller/screens/shop_details/model/product_model.dart';

class ProductController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> searchProductList = <ProductModel>[].obs;
  RxString searchText = "".obs;

  setSearchText(String v) {
    searchText.value = v;
  }

  setProductList(List<ProductModel> pl) {
    productList.value = pl;
  }

  setSearchProductList(List<ProductModel> spl) {
    searchProductList.value = spl;
  }

  updateProductList(ProductModel p, int index) {
    productList[index] = p;
  }

  updateSearchProductList(ProductModel sp, int index) {
    searchProductList[index] = sp;
  }

  clearProductList() {
    productList.clear();
  }

  clearSearchProductList() {
    searchProductList.clear();
  }

  clear() {
    searchText.value = "";
    productList.clear();
    searchProductList.clear();
  }
}
