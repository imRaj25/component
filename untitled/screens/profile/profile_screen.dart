import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haatinhandseller/common_widget/custom_alert_dialog.dart';
import 'package:haatinhandseller/common_widget/custom_appbar.dart';
import 'package:haatinhandseller/common_widget/icon_title_icon_bar.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/constans/helpers/shared_prefs.dart';
import 'package:haatinhandseller/controllers/product_controller.dart';
import 'package:haatinhandseller/controllers/profile_controller.dart';
import 'package:haatinhandseller/controllers/shop_controller.dart';
import 'package:haatinhandseller/screens/about_us/about_us_screen.dart';
import 'package:haatinhandseller/screens/auth/signin/signin_screen.dart';
import 'package:haatinhandseller/screens/help/help_support_screen.dart';
import 'package:haatinhandseller/screens/notifications_screen/notifications_screen.dart';
import 'package:haatinhandseller/screens/profile/your_profile.dart';
import 'package:haatinhandseller/screens/settings/settings_screen.dart';
import 'package:haatinhandseller/screens/subscription/subscription_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find();
  final ProductController productController = Get.find();
  final ShopController shopController = Get.find();
  SharedPrefs sharedPrefs = SharedPrefs();
  bool showSellerPaymentOption = false;
  bool showSellerFaqOption = false;
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    inInitialCall();
    super.initState();
  }

  inInitialCall() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {});
    }
    final remoteConfig = FirebaseRemoteConfig.instance;
    showSellerPaymentOption = remoteConfig.getBool("showSellerPaymentOption");
    showSellerFaqOption = remoteConfig.getBool("showSellerFaqOption");
    if (mounted) {
      setState(() {});
    }
    remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      await remoteConfig.activate();
      showSellerPaymentOption = remoteConfig.getBool("showSellerPaymentOption");
      showSellerFaqOption = remoteConfig.getBool("showSellerFaqOption");
      //  bannerText=remoteConfig.getString ("bannerText");
      if (mounted) {
        setState(() {});
      }
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
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColorConstant.normalGrey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: profileController.profile.value.profileImage == ""
                          ? Image.asset("assets/images/user.png",
                              height: 120,
                              width: 120,
                              color: const Color.fromARGB(255, 120, 120, 120),
                              fit: BoxFit.fill)
                          : Image.network(
                              profileController.profile.value.profileImage!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.fill),
                    ),
                  ),
                ),
                Center(
                  child: Obx(
                    () => Text(profileController.profile.value.name ?? "",
                        style: const TextStyle(
                          color: AppColorConstant.blackColor,
                          fontSize: 20,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                IconTitleIconBar(
                    onTap: () {
                      nextPage(
                        context: context,
                        widget: const YourProfileScreen(),
                      );
                    },
                    title: "Your Profile",
                    startIcon: Icons.person_outline_outlined,
                    endIcon: Icons.chevron_right),
                Visibility(
                  visible: showSellerPaymentOption,
                  child: IconTitleIconBar(
                      onTap: () {
                        nextPage(
                            context: context,
                            widget: const SubscriptionScreen());
                      },
                      title: "Subscription",
                      startIcon: Icons.subscriptions_outlined,
                      endIcon: Icons.chevron_right),
                ),
                IconTitleIconBar(
                    onTap: () {
                      nextPage(
                          context: context,
                          widget: const NotificationsScreen());
                    },
                    title: "Notifications",
                    startIcon: Icons.notifications_outlined,
                    endIcon: Icons.chevron_right),
                IconTitleIconBar(
                    onTap: () {
                      nextPage(
                        context: context,
                        widget: const SettingsScreen(),
                      );
                    },
                    title: "Settings",
                    startIcon: Icons.settings_outlined,
                    endIcon: Icons.chevron_right),
                Visibility(
                  visible: showSellerFaqOption,
                  child: IconTitleIconBar(
                      onTap: () {
                        nextPage(
                          context: context,
                          widget: const HelpSupportScreen(),
                        );
                      },
                      title: "Help & Support",
                      startIcon: Icons.info_outline,
                      endIcon: Icons.chevron_right),
                ),
                IconTitleIconBar(
                    onTap: () {
                      nextPage(
                        context: context,
                        widget: const AboutUsScreen(),
                      );
                    },
                    title: "About Us",
                    startIcon: Icons.info_outline,
                    endIcon: Icons.chevron_right),
                IconTitleIconBar(
                    onTap: () async {
                      var url = Uri.parse(
                          "https://abcdomain.com/terms-and-conditions");
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    title: "Terms & Conditions",
                    startIcon: Icons.gavel_outlined,
                    endIcon: Icons.chevron_right),
                IconTitleIconBar(
                    onTap: () async {
                      var url = Uri.parse(
                          "https://abcdomain.com/privacy-and-policies");
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    title: "Privacy & Policies",
                    startIcon: Icons.policy_outlined,
                    endIcon: Icons.chevron_right),
                IconTitleIconBar(
                    onTap: () {
                      CustomAlertDialog.showDialogWithCancel(
                        "Alert!",
                        "Are you sure you want to logout?",
                        context,
                        statusEnum: StatusEnum.warning,
                        onOkClick: () async {
                          await sharedPrefs.clear();
                          profileController.clear();
                          productController.clear();
                          shopController.clear();
                          // ignore: use_build_context_synchronously
                          removeUntil(
                            context: context,
                            widget: const SignInScreen(),
                          );
                        },
                      );
                    },
                    title: "Logout",
                    startIcon: Icons.logout,
                    endIcon: Icons.chevron_right),
                SizedBox(height: h * 0.31),
                Text("version: ${packageInfo.version}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
