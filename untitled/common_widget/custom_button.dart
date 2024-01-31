import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';

class CustomButton extends StatefulWidget {
  final Function() func;
  final String label;
  final Color bgColor;
  final Color labelColor;
  final double borderRadius;
  const CustomButton(
      {required this.func,
      required this.label,
      this.bgColor = AppColorConstant.primaryColor,
      this.labelColor = AppColorConstant.whiteColor,
      this.borderRadius = 50.0,
      super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.func,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.bgColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
      child: Text(
        widget.label,
        style: TextStyle(color: widget.labelColor),
      ),
    );
  }
}
