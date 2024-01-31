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

class VerifySignupOtpScreen extends StatefulWidget {
  final dynamic userData;
  const VerifySignupOtpScreen({required this.userData, super.key});

  @override
  State<VerifySignupOtpScreen> createState() => _VerifySignupOtpScreenState();
}

class _VerifySignupOtpScreenState extends State<VerifySignupOtpScreen> {
  final ProfileController profileController = Get.find();
  SharedPrefs sharedPrefs = SharedPrefs();
  String otp = "";
  bool enableResend = false;

  Future<void> loginApiCall({required dynamic body}) async {
    try {
      context.loaderOverlay.show();
      Uri myUri = Uri.parse(verifyLoginOtpEndpoint);
      var request =
          HttpClientPostRequestModel(uri: myUri, body: jsonEncode(body));
      ApiResponseModel response = await HttpClientService.post(request);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, message: response.message);
        var token = jsonDecode(response.response)['token'];
        await sharedPrefs.sharedPrefsLoginToken(type: "write", data: token);
        getProfileData();
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context, message: response.message, isError: true);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();
    }
  }

  getProfileData() async {
    try {
      Uri myUri = Uri.parse(profileEndpoint);
      var request = HttpClientGetRequestModel(uri: myUri);
      ApiResponseModel response = await HttpClientService.get(request);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.response)['data'];
        var profileModel = SellerProfileModel.fromJson(jsonData);
        profileController.setProfile(profileModel);
        if (profileController.profile.value.hasDeleteRequest == true) {
          // ignore: use_build_context_synchronously
          removeUntil(
              context: context, widget: const DeleteProfileWarningScreen());
        } else {
          // ignore: use_build_context_synchronously
          removeUntil(context: context, widget: const HomeScreen());
        }
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context, message: response.message, isError: true);
      }
    } catch (e) {
      log(e.toString());
    }
  }

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
                      text:
                          "\n${widget.userData['countryCode']} ${widget.userData['mobile']}",
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
                          getSignupOTPApiCall();
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
                          var reqBody = widget.userData;
                          reqBody["inputOTP"] = otp;
                          verifyOtpAndRegisterApiCall(body: reqBody);
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
