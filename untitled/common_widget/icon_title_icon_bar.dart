import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconTitleIconBar extends StatelessWidget {
  Function onTap;
  IconData? startIcon;
  IconData? endIcon;
  String title;
  bool showDivider;
  IconTitleIconBar(
      {super.key,
      required this.onTap,
      required this.title,
      this.startIcon,
      this.endIcon,
      this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2, top: 2),
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
          //border bottom
          border: showDivider
              ? const Border(
                  bottom: BorderSide(
                    color: AppColorConstant.normalGrey,
                    width: 1.0,
                  ),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap();
          },
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: const EdgeInsets.only(bottom: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (startIcon != null)
                      Icon(
                        startIcon,
                        color: AppColorConstant.primaryColor,
                      ),
                    if (startIcon != null)
                      const SizedBox(
                        width: 5,
                      ),
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColorConstant.blackColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                if (endIcon != null)
                  Icon(
                    endIcon,
                    color: AppColorConstant.primaryColor,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
