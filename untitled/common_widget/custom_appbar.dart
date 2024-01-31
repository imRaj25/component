import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';

Widget customAppBar(
    {BuildContext? context,
    String title = "",
    String icon = "",
    popEnable = true,
    Color? backgroundColor}) {
  return Container(
    color: backgroundColor ?? Colors.transparent,
    height: 65,
    width: MediaQuery.of(context!).size.width,
    child: Stack(
      children: [
        Visibility(
          visible: popEnable,
          child: Positioned(
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColorConstant.whiteColor,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColorConstant.whiteColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(14.0),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: title.isNotEmpty,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: AppFontSizeConstant.fontSize18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Visibility(
          visible: icon.isNotEmpty,
          child: Center(
            child: Image.asset(
              icon,
              color: Colors.black,
              width: 150.0,
            ),
          ),
        ),
      ],
    ),
  );
}
