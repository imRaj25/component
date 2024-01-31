import 'dart:math';

class AppAssetConstant {
  static const String haatinhandWellcome =
      "assets/images/haatinhand-welcome.png";
  static const String haatinhandWellcome2 =
      "assets/images/haatinhand-welcome2.png";
  static const String haatinhandLogo = "assets/images/haatinhand-logo.png";
  static const String seller = "assets/images/seller.png";
  static const String haatinhandLogoBG = "assets/images/haatinhand-logo-bg.png";
  static const String haatinhandLogoLBG = "assets/images/bg.png";
  static const String chatillustration = "assets/images/chat_ill.png";
    static const String nonotification = "assets/images/no_notification.png";
}

getProductImage() {
  int i = Random().nextInt(3);
  List<String> imageList = [
    "https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/614QPGx+HmL._SY879_.jpg",
    "https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/51MTOcHyhZL._SX679_.jpg",
    "https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/61fzad+OXVL._SX679_.jpg",
    "https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71ZJM+pgv4L._SX679_.jpg",
  ];

  return imageList[i];
}
