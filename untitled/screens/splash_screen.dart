import 'dart:io';

import 'package:get/get.dart';
import 'package:haatinhandseller/common_widget/custom_alert_dialog.dart';
import 'package:haatinhandseller/constans/asset_constants/asset_constants.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/constans/helpers/shared_prefs.dart';
import 'package:haatinhandseller/controllers/product_controller.dart';
import 'package:haatinhandseller/controllers/profile_controller.dart';
import 'package:haatinhandseller/controllers/shop_controller.dart';
import 'package:haatinhandseller/screens/home/home_screen.dart';
import 'package:haatinhandseller/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final profileController = Get.put(ProfileController());
  final shopController = Get.put(ShopController());
  final productController = Get.put(ProductController());

  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  void initState() {
    _onInitialCall();
    super.initState();
  }

  _onInitialCall() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      // ignore: use_build_context_synchronously
      CustomAlertDialog.showMyDialog(
        "Alert!",
        "No Internet Connection",
        context,
        statusEnum: StatusEnum.warning,
        onOkClick: () async {
          exit(0);
        },
      );
      return;
    }
    String token = await sharedPrefs.sharedPrefsLoginToken();
    Future.delayed(const Duration(seconds: 5), () {
      removeUntil(
          context: context,
          widget: token.isEmpty ? const WelcomeScreen() : const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: AppColorConstant.primaryColor,
        body: Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff1a2033),
              Color.fromARGB(255, 9, 148, 212),
              Color(0xff1a2033),
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAssetConstant.haatinhandLogo,
            width: 275,
          ),
          const SizedBox(height: 4.0),
          Image.asset(
            AppAssetConstant.seller,
            width: 245,
          ),
          const SizedBox(height: 12.0),
          const Text(
            "Connect • Discuss • Delight\nThe Route to In-Person Satisfaction.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    ));
  }
}
