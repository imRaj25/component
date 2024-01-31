import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:haatinhandseller/common_widget/custom_button.dart';
import 'package:haatinhandseller/common_widget/input_comp.dart';
import 'package:haatinhandseller/common_widget/show_snackbar.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/models/api_response_model.dart';
import 'package:haatinhandseller/remote_service/http_client_request_model.dart';
import 'package:haatinhandseller/remote_service/http_client_service.dart';
import 'package:haatinhandseller/screens/auth/endpoint/auth_endpoint.dart';
import 'package:haatinhandseller/screens/auth/signup/signup_screen.dart';
import 'package:haatinhandseller/screens/auth/verify/verify_otp_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String cc = "+91";
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signinApiCall({required dynamic body}) async {
    try {
      context.loaderOverlay.show();
      Uri myUri = Uri.parse(loginEndpoint);
      var request =
          HttpClientPostRequestModel(uri: myUri, body: jsonEncode(body));
      ApiResponseModel response = await HttpClientService.post(request);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, message: response.message);
        // ignore: use_build_context_synchronously
        nextPage(
            context: context,
            widget: VerifyOtpScreen(
              cc: cc,
              phone: phoneController.text,
            ));
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25.0),

                Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: AppFontSizeConstant.fontSize22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 25.0),
                Center(
                  child: Text(
                    "Hi! Welcome back, you've been missed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppFontSizeConstant.fontSize14,
                        color: AppColorConstant.subHeadingColor),
                  ),
                ),
                SizedBox(height: h * 0.1),

                //email or phone
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    "",
                    style: TextStyle(
                        fontSize: AppFontSizeConstant.fontSize16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                InputComp(
                  hint: 'Mobile Number',
                  controller: phoneController,
                  prefixIcon: const Icon(
                    Icons.numbers,
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Phone number is required";
                    } else if (v.length < 10) {
                      return "Phone number is not valid";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25.0),

                //signup button
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: w,
                    child: CustomButton(
                        func: () {
                          if (_formKey.currentState!.validate()) {
                            var reqBody = {};
                            signinApiCall(body: reqBody);
                          }
                        },
                        label: "Sign In"),
                  ),
                ),

                // //other signup options
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(55.0, 45.0, 55.0, 35.0),
                //   child: Row(
                //     children: [
                //       const Expanded(
                //           flex: 1,
                //           child: Divider(
                //             thickness: 1.3,
                //             color: AppColorConstant.subHeadingColor,
                //           )),
                //       Text(
                //         "\t\tOr sign in with\t\t",
                //         style: TextStyle(
                //             fontSize: AppFontSizeConstant.fontSize14,
                //             color: AppColorConstant.subHeadingColor),
                //       ),
                //       const Expanded(
                //           flex: 1,
                //           child: Divider(
                //             thickness: 1.3,
                //             color: AppColorConstant.subHeadingColor,
                //           )),
                //     ],
                //   ),
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const SizedBox(width: 16.0),
                //     socialOption(icon: Icons.apple, func: () {}),
                //     const SizedBox(width: 16.0),
                //     socialOption(icon: Icons.g_mobiledata, func: () {}),
                //     const SizedBox(width: 16.0),
                //     socialOption(
                //         icon: Icons.facebook, color: Colors.blue, func: () {}),
                //   ],
                // ),

                SizedBox(height: h * 0.25),

                //have account sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize16,
                          color: AppColorConstant.blackColor),
                    ),
                    TextButton(
                      onPressed: () {
                        replacePage(
                            context: context, widget: const SignUpScreen());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: AppFontSizeConstant.fontSize16,
                            decoration: TextDecoration.underline,
                            color: AppColorConstant.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  socialOption(
      {IconData? icon,
      Function()? func,
      Color color = AppColorConstant.blackColor}) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.0),
      onTap: func,
      child: Container(
        height: 70.0,
        width: 70.0,
        decoration: BoxDecoration(
            border: Border.all(color: AppColorConstant.greyColor),
            shape: BoxShape.circle),
        child: Icon(
          icon,
          color: color,
          size: 35.0,
        ),
      ),
    );
  }
}
