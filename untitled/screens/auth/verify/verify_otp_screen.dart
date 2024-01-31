import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haatinhandseller/common_widget/custom_appbar.dart';
import 'package:haatinhandseller/common_widget/custom_button.dart';
import 'package:haatinhandseller/common_widget/pin_comp.dart';
import 'package:haatinhandseller/common_widget/show_snackbar.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/constans/helpers/shared_prefs.dart';
import 'package:haatinhandseller/controllers/profile_controller.dart';
import 'package:haatinhandseller/models/api_response_model.dart';
import 'package:haatinhandseller/remote_service/http_client_request_model.dart';
import 'package:haatinhandseller/remote_service/http_client_service.dart';
import 'package:haatinhandseller/screens/auth/endpoint/auth_endpoint.dart';
import 'package:haatinhandseller/screens/home/home_screen.dart';
import 'package:haatinhandseller/screens/profile/endpoint/profile_endpoint.dart';
import 'package:haatinhandseller/screens/profile/model/profile_model.dart';
import 'package:haatinhandseller/screens/settings/delete_profile_warning_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String? cc;
  final String? phone;
  const VerifyOtpScreen({this.cc, this.phone, super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final ProfileController profileController = Get.find();
  SharedPrefs sharedPrefs = SharedPrefs();
  String otp = "";
  bool enableResend = false;

  @override
  void initState() {
    resendOtpCounter();
    super.initState();
  }

  resendOtpCounter() {
    Future.delayed(const Duration(seconds: 120), () {
      setState(() {
        enableResend = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: h,
          width: w,
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                customAppBar(context: context),
                const SizedBox(height: 25.0),
                Center(
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                        fontSize: AppFontSizeConstant.fontSize22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 25.0),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                      text: "Please enter the code we just sent to mobile",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize14,
                          color: AppColorConstant.subHeadingColor),
                    ),
                    TextSpan(
                      text: "\n${widget.cc} ${widget.phone}",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize15,
                          fontWeight: FontWeight.w500,
                          color: AppColorConstant.primaryColor),
                    )
                  ]),
                ),
                SizedBox(height: h * 0.05),

                //otp field
                PinComp(
                  onChanged: (pin) {
                    setState(() {
                      otp = pin;
                    });
                  },
                ),

                SizedBox(height: h * 0.08),

                Text("Didn't receive OTP?",
                    style: TextStyle(
                        fontSize: AppFontSizeConstant.fontSize14,
                        color: AppColorConstant.subHeadingColor)),
                const SizedBox(height: 8.0),
                InkWell(
                  borderRadius: BorderRadius.circular(4.0),
                  onTap: !enableResend
                      ? null
                      : () {
                          getOTPApiCall();
                        },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: enableResend
                              ? AppColorConstant.blackColor
                              : AppColorConstant.greyColor),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.08),

                //button
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: w * 0.85,
                    child: CustomButton(
                        func: () {
                          if (otp.length < 4) {
                            return showSnackBar(
                                context: context,
                                message: "Please enter valid OTP",
                                isError: true);
                          }
                          var reqBody = {
                            "countryCode": widget.cc!,
                            "mobile": widget.phone!,
                            "loginOTP": otp
                          };
                          verifyOtpApiCall(body: reqBody);
                        },
                        label: "Verify"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
