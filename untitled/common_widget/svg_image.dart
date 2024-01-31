import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget showSvgImage({String? assetName, String? label, Color? color}) {
  return SvgPicture.asset(assetName!,
      semanticsLabel: label,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null);
}
