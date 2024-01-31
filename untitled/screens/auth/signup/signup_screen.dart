import 'dart:convert';
import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:haatinhandseller/common_widget/custom_button.dart';
import 'package:haatinhandseller/common_widget/custom_dropdown.dart';
import 'package:haatinhandseller/common_widget/input_comp.dart';
import 'package:haatinhandseller/common_widget/show_snackbar.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';
import 'package:haatinhandseller/constans/gender_list/gender_list.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/models/api_response_model.dart';
import 'package:haatinhandseller/remote_service/http_client_request_model.dart';
import 'package:haatinhandseller/remote_service/http_client_service.dart';
import 'package:haatinhandseller/screens/auth/endpoint/auth_endpoint.dart';
import 'package:haatinhandseller/screens/auth/signin/signin_screen.dart';
import 'package:haatinhandseller/screens/auth/verify-signup/verify_signup_otp_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String cc = "+91";
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController referredByController = TextEditingController();
  List<DropdownMenuItem> stateList = [];
  bool showSellerReferredBy = false;

  var signupVars = {};

  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final remoteConfig = FirebaseRemoteConfig.instance;
    showSellerReferredBy = remoteConfig.getBool("showSellerReferredBy");
    if (mounted) {
      setState(() {});
    }
    remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      await remoteConfig.activate();
      showSellerReferredBy = remoteConfig.getBool("showSellerReferredBy");
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
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
                      "Create Account",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Center(
                    child: Text(
                      "Fill your information bellow or register\nwith your social account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize14,
                          color: AppColorConstant.subHeadingColor),
                    ),
                  ),
                  const SizedBox(height: 25.0),

                  //name
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InputComp(
                    hint: 'Your Name',
                    controller: nameController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),

                  //gender
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomDropdown(
                    list: genderList,
                    hint: "select",
                    controller: genderController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Gender is required";
                      }
                      return null;
                    },
                  ),

                  //phone
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      "Phone",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InputComp(
                    hint: 'Mobile Number',
                    controller: phoneController,
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

                  //state
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      "State",
                      style: TextStyle(
                          fontSize: AppFontSizeConstant.fontSize16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomDropdown(
                    list: stateList,
                    hint: "select",
                    controller: stateController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "State is required";
                      }
                      return null;
                    },
                  ),

                  //referred by
                  Visibility(
                    visible: showSellerReferredBy,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        "Referred By",
                        style: TextStyle(
                            fontSize: AppFontSizeConstant.fontSize16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showSellerReferredBy,
                    child: InputComp(
                      hint: 'Referred By',
                      controller: referredByController,
                    ),
                  ),

                  const SizedBox(height: 12.0),

                  //terms & condition
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          visualDensity: VisualDensity.compact,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColorConstant.whiteColor),
                          checkColor: AppColorConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                    color: AppColorConstant.primaryColor,
                                    width: 1.0,
                                  )),
                          value: isChecked,
                          onChanged: (v) {
                            setState(() {
                              isChecked = v!;
                            });
                          },
                        ),
                      ),
                      Text("Agree with ",
                          style: TextStyle(
                              fontSize: AppFontSizeConstant.fontSize16)),
                      InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () async {
                          var url = Uri.parse(
                              "https://abcdomain.com/terms-and-conditions");
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                          child: Text(
                            "Terms & Conditions",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: AppFontSizeConstant.fontSize16,
                                color: AppColorConstant.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),

                  //signup button
                  Center(
                    child: SizedBox(
                      height: 50.0,
                      width: w * 0.85,
                      child: CustomButton(
                          func: () async {
                            if (_formKey.currentState!.validate()) {
                              if (isChecked) {
                                signupVars = {};
                                var reqBody = {};
                                getSignupOTPApiCall(body: reqBody);
                              } else {
                                showSnackBar(
                                    context: context,
                                    message:
                                        "Please agree with Terms & Conditions",
                                    isError: true);
                                return;
                              }
                            }
                          },
                          label: "Sign Up"),
                    ),
                  ),

                  const SizedBox(height: 35.0),

                  //have account sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: AppFontSizeConstant.fontSize16,
                            color: AppColorConstant.blackColor),
                      ),
                      TextButton(
                        onPressed: () {
                          replacePage(
                              context: context, widget: const SignInScreen());
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: AppFontSizeConstant.fontSize16,
                              decoration: TextDecoration.underline,
                              color: AppColorConstant.primaryColor),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
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
