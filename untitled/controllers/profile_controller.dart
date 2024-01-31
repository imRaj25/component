import 'package:get/get.dart';
import 'package:haatinhandseller/screens/profile/model/profile_model.dart';

class ProfileController extends GetxController {
  Rx<SellerProfileModel> profile = SellerProfileModel().obs;

  setProfile(SellerProfileModel p) {
    profile.value = p;
  }

  clear() {
    profile.value = SellerProfileModel();
  }
}
