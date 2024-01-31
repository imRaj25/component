import 'package:flutter/material.dart';
import 'package:haatinhandseller/common_widget/custom_button.dart';
import 'package:haatinhandseller/constans/asset_constants/asset_constants.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/screens/auth/signin/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(AppAssetConstant.haatinhandWellcome2),
          Column(
            children: [
              const Text(
                "Welcome!",
                style: TextStyle(fontFamily: "Philosopher", fontSize: 54.0),
              ),
              Text(
                "Your app\nYour market\nYour community",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: "Philosopher",
                  color: Colors.grey.shade600,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
            width: w * 0.50,
            child: CustomButton(
                func: () {
                  nextPage(context: context, widget: const SignInScreen());
                },
                borderRadius: 8.0,
                label: "Get Started"),
          ),
        ]),
      ),
    );
  }
}
