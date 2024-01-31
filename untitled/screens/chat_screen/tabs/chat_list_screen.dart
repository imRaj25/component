import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/asset_constants/asset_constants.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/controllers/profile_controller.dart';
import 'package:haatinhandseller/screens/chat_screen/chat_api_service.dart/chat_api_service.dart';
import 'package:haatinhandseller/screens/chat_screen/widget/chat_widget.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child: StreamBuilder(
            stream: getChats(userID: profileController.profile.value.id ?? ""),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  if (snapshot.data!.docs.isEmpty) {
                    return Image.asset(AppAssetConstant.chatillustration);
                  }
                  return SingleChildScrollView(
                    child: Column(children: [
                      for (var chat in snapshot.data!.docs)
                        chat.data()['createdOn'] == chat.data()['updateOn']
                            ? Container()
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(7.0),
                                      onTap: () {
                                        nextPage(
                                          context: context,
                                          widget: ChatWidget(
                                            customerID: chat.data()['users'][0],
                                            customerName:
                                                chat.data()['customerName'],
                                            customerImage:
                                                chat.data()['customerImage'],
                                            roomID: chat.id,
                                            productID: chat.data()['product']
                                                [0],
                                            productTitle: chat.data()['product']
                                                [1],
                                            productImage: chat.data()['product']
                                                [2],
                                            isActive: chat.data()['isActive'],
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: chat.data()[
                                                            'customerImage'] ==
                                                        ""
                                                    ? Image.asset(
                                                        "assets/images/user.png",
                                                        height: 120,
                                                        width: 120,
                                                        color: AppColorConstant
                                                            .grayDark,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.network(
                                                        chat.data()[
                                                            'customerImage'],
                                                        height: 120,
                                                        width: 120,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            SizedBox(
                                              width: w * 0.7,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    chat.data()['customerName'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    chat.data()['product'][1],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 6.0),
                                                  SizedBox(
                                                    width: w * 0.5,
                                                    child: Text(
                                                      chat.data()['lastMessage'] ==
                                                              ""
                                                          ? "Say hi!"
                                                          : chat.data()[
                                                              'lastMessage'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              AppColorConstant
                                                                  .greyColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                ],
                              )
                    ]),
                  );
                default:
                  return const SizedBox();
              }
            }),
      ),
    );
  }
}
