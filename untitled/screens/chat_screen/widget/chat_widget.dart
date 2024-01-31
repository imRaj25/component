import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/controllers/profile_controller.dart';
import 'package:haatinhandseller/screens/chat_screen/chat_api_service.dart/chat_api_service.dart';
import 'package:haatinhandseller/screens/chat_screen/model/message_model.dart';
import 'package:haatinhandseller/common_widget/marquee.dart';
import 'package:haatinhandseller/screens/product_details/product_detail.dart';

class ChatWidget extends StatefulWidget {
  final String customerID;
  final String customerName;
  final String customerImage;
  final String roomID;
  final String productID;
  final String productImage;
  final String productTitle;
  final bool isActive;
  const ChatWidget(
      {required this.roomID,
      required this.customerID,
      required this.customerName,
      required this.customerImage,
      required this.productID,
      required this.productImage,
      required this.productTitle,
      required this.isActive,
      super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final ProfileController profileController = Get.find();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController msgController = TextEditingController();
  List<MessageModel> messageList = [];

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  getMessages() async {
    firestore
        .collection('Rooms/${widget.roomID}/Messages/')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        messageList.clear();
        for (var element in event.docs) {
          if (mounted) {
            setState(() {
              var message = MessageModel.fromJson(element.data());
              messageList.add(message);
            });
          }
        }
        if (mounted) {
          scrollToBottom();
        }
      }
    });
  }

  ScrollController scrollController = ScrollController();

  scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        backgroundColor: AppColorConstant.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        leadingWidth: 45.0,
        leading: Center(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25.0,
                color: AppColorConstant.whiteColor,
              )),
        ),
        title: Row(children: [
          CircleAvatar(
            radius: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: widget.customerImage == ""
                  ? Image.asset(
                      "assets/images/user.png",
                      height: 60,
                      width: 60,
                      color: AppColorConstant.grayDark,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      widget.customerImage,
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.customerName,
                style: TextStyle(
                  fontSize: AppFontSizeConstant.fontSize16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6.0),
              SizedBox(
                height: 20,
                width: w * 0.57,
                child: GestureDetector(
                  onTap: () {
                    nextPage(
                      context: context,
                      widget: ProductDetail(
                        productID: widget.productID,
                      ),
                    );
                  },
                  child: Marquee(
                    text: widget.productTitle.padRight(12, '_'),
                    style: TextStyle(
                      fontSize: AppFontSizeConstant.fontSize12,
                    ),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 75.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.1,
                    fadingEdgeEndFraction: 0.1,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(seconds: 1),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      body: Container(
        height: h,
        width: w,
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        color: AppColorConstant.backgroundColor,
        child: Column(
          children: [
            //list builder
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: messageList.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Visibility(
                      visible: index == 0,
                      child: Column(
                        children: [
                          const SizedBox(height: 12.0),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: AppColorConstant.backgroundColor),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: Image.network(
                                widget.productImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                nextPage(
                                  context: context,
                                  widget: ProductDetail(
                                    productID: widget.productID,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: SizedBox(
                                  width: w * 0.7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.productTitle,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.blue),
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      const Icon(
                                        Icons.open_in_new,
                                        size: 18.0,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                        ],
                      ),
                    ),
                    Align(
                      alignment: messageList[index].fromId ==
                              profileController.profile.value.id
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Container(
                          // width: w * 0.8,
                          constraints: BoxConstraints(maxWidth: w * 0.8),
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: messageList[index].fromId ==
                                    profileController.profile.value.id
                                ? Colors.blue.shade600
                                : AppColorConstant.normalGreyTwo,
                          ),
                          child: Text(
                            messageList[index].msg,
                            maxLines: 9999999,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: messageList[index].fromId ==
                                        profileController.profile.value.id
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //message
            !widget.isActive
                ? Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      "This chat is no longer active.",
                      style: TextStyle(
                          color: AppColorConstant.greyColor,
                          fontSize: AppFontSizeConstant.fontSize15,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                    child: TextFormField(
                      controller: msgController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColorConstant.greyColor),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColorConstant.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: "Type here",
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () async {
                              if (msgController.text.isEmpty) {
                                return;
                              }
                              var message = MessageModel(
                                msg: msgController.text.trim(),
                                fromId: profileController.profile.value.id!,
                                toId: widget.customerID,
                                type: Type.text,
                                read: "false",
                                sent: DateTime.now().toString(),
                              );
                              await sendMessage(
                                roomID: widget.roomID,
                                message: message,
                              );
                              var notificationBody = {
                                "userID": widget.customerID,
                                "title": "New Message",
                                "body": msgController.text.trim(),
                                "userType": "Customer"
                              };
                              log(notificationBody.toString());
                              await sendNotificationApiCall(
                                  body: notificationBody);
                              msgController.clear();
                              // ignore: use_build_context_synchronously
                              FocusScope.of(context).unfocus();
                            },
                            icon: const Icon(Icons.send,
                                color: AppColorConstant.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
