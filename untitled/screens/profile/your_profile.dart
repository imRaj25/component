import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haatinhandseller/common_widget/custom_appbar.dart';
import 'package:haatinhandseller/common_widget/custom_button.dart';
import 'package:haatinhandseller/common_widget/custom_dropdown.dart';
import 'package:haatinhandseller/common_widget/image_picker_widget.dart';
import 'package:haatinhandseller/common_widget/input_comp.dart';
import 'package:haatinhandseller/common_widget/show_snackbar.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';
import 'package:haatinhandseller/constans/gender_list/gender_list.dart';
import 'package:haatinhandseller/controllers/profile_controller.dart';
import 'package:haatinhandseller/models/api_response_model.dart';
import 'package:haatinhandseller/models/file_model.dart';
import 'package:haatinhandseller/remote_service/http_client_request_model.dart';
import 'package:haatinhandseller/remote_service/http_client_service.dart';
import 'package:haatinhandseller/screens/auth/endpoint/auth_endpoint.dart';
import 'package:haatinhandseller/screens/profile/endpoint/profile_endpoint.dart';
import 'package:haatinhandseller/screens/profile/model/profile_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  final ProfileController profileController = Get.find();
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FileModel? imageFile;
  List<DropdownMenuItem> stateList = [];

  @override
  void initState() {
    stateApiCall();
    ccController.text = "+91";
    nameController.text = profileController.profile.value.name!;
    phoneController.text = profileController.profile.value.mobile!;
    genderController.text = profileController.profile.value.gender!;
    stateController.text = profileController.profile.value.state?.id ?? "";
    super.initState();
  }

  void stateApiCall() async {
    try {
      context.loaderOverlay.show();
      Uri myUri = Uri.parse(stateEndpoint);
      var request = HttpClientGetRequestModel(uri: myUri);
      ApiResponseModel response = await HttpClientService.get(request);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.response)['data'];
        for (var item in jsonData) {
          stateList.add(
            DropdownMenuItem(
              value: item['id'],
              child: Text(
                item['name'],
              ),
            ),
          );
        }
        if (mounted) {
          setState(() {});
        }
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

  updateProfileApiCall({required Map<String, dynamic> body}) async {
    try {
      context.loaderOverlay.show();

      if (imageFile != null) {
        context.loaderOverlay.show();
        ApiResponseModel imageResponse =
            await HttpClientService.multipartPostRequest(
                apiurl: profileImageEndpoint,
                requestBody: "",
                files: [imageFile!]);
        if (imageResponse.statusCode == 200) {
          String imageLink = jsonDecode(imageResponse.response)['data'];
          body['image'] = imageLink;
        } else {
          // ignore: use_build_context_synchronously
          return showSnackBar(
              context: context, message: imageResponse.message, isError: true);
        }
      }
      Uri myUri = Uri.parse(profileEndpoint);
      var request =
          HttpClientPutRequestModel(uri: myUri, body: jsonEncode(body));
      ApiResponseModel response = await HttpClientService.put(request);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, message: response.message);
        getProfileData();
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context, message: response.message, isError: true);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, message: e.toString(), isError: true);
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
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context, message: response.message, isError: true);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, message: e.toString(), isError: true);
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
              child: Column(
                children: [
                  customAppBar(context: context, title: "Your Profile"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25.0),

                      //profile picture
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: AppColorConstant.normalGrey,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: imageFile != null
                                    ? Image.file(imageFile!.file,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill)
                                    : Obx(
                                        () => profileController.profile.value
                                                    .profileImage ==
                                                ""
                                            ? Image
                                                .asset("assets/images/user.png",
                                                    height: 100,
                                                    width: 100,
                                                    color: const Color.fromARGB(
                                                        255, 100, 100, 120),
                                                    fit: BoxFit.fill)
                                            : Image.network(
                                                profileController.profile.value
                                                    .profileImage!,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.fill),
                                      ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50.0),
                                  onTap: () {
                                    callImagePicker(
                                        context: context,
                                        onImagePicked: (file) {
                                          setState(() {
                                            imageFile = file;
                                          });
                                        });
                                  },
                                  child: const CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor:
                                        AppColorConstant.primaryColor,
                                    child: Icon(
                                      Icons.border_color_outlined,
                                      size: 16.0,
                                      color: AppColorConstant.whiteColor,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

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
                        hint: 'Jenny Wilson',
                        controller: nameController,
                        validator: (v) {
                          if (v!.isEmpty) {
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

                      const SizedBox(height: 35.0),

                      //button
                      Center(
                        child: SizedBox(
                          height: 50.0,
                          width: w * 0.85,
                          child: CustomButton(
                              func: () {
                                if (_formKey.currentState!.validate()) {
                                  var reqBody = {
                                    "name": nameController.text.trim(),
                                  };
                                  updateProfileApiCall(body: reqBody);
                                }
                              },
                              label: "Update"),
                        ),
                      ),

                      const SizedBox(height: 25.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
