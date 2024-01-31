import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/screens/chat_screen/tabs/chat_list_screen.dart';
// import 'package:haatinhand/screens/chat_screen/tabs/story_screen.dart';

class ChatTabScreen extends StatefulWidget {
  const ChatTabScreen({super.key});

  @override
  State<ChatTabScreen> createState() => _ChatTabScreenState();
}

class _ChatTabScreenState extends State<ChatTabScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          // centerTitle: false,
          toolbarHeight: 35.0,
          title: Image.asset(
            "assets/images/haatinhand-logo.png",
            color: Colors.black,
            width: 150.0,
          ),
          bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: AppColorConstant.greyColor,
              tabs: [
                Tab(
                  child: Text(
                    "Chats",
                  ),
                ),
                // Tab(
                //   child: Text(
                //     "Story",
                //   ),
                // ),
              ]),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: ChatListScreen(),
            ),
            // Center(
            //   child: StoryScreen(),
            // ),
          ],
        ),
      ),
    );
  }
}
