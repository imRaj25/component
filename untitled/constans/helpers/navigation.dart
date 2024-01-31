import 'package:flutter/cupertino.dart';

nextPage({BuildContext? context, Widget? widget}) {
  Navigator.push(
    context!,
    CupertinoPageRoute(builder: (context) => widget!),
  );
}

replacePage({BuildContext? context, Widget? widget}) {
  Navigator.pushReplacement(
    context!,
    CupertinoPageRoute(builder: (context) => widget!),
  );
}

removeUntil({BuildContext? context, Widget? widget}) {
  Navigator.pushAndRemoveUntil(
    context!,
    CupertinoPageRoute(builder: (context) => widget!),
    (route) => false,
  );
}
