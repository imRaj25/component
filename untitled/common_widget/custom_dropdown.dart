import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String? Function(dynamic)? validator;
  final Function(dynamic)? onChange;
  final List<DropdownMenuItem> list;
  final double menuHeight;
  final TextEditingController controller;
  final Color borderColor;
  final double borderRadius;
  final String hint;
  const CustomDropdown(
      {required this.list,
      this.validator,
      required this.hint,
      this.borderRadius = 10.0,
      this.borderColor = AppColorConstant.inputBorderColor,
      required this.controller,
      this.onChange,
      this.menuHeight = 400.0,
      super.key});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.controller.text == "" ? null : widget.controller.text,
      validator: widget.validator,
      // autovalidateMode: Auto,
      items: widget.list,
      menuMaxHeight: widget.menuHeight,
      decoration: InputDecoration(
        fillColor: const Color(0xffFFFFFF),
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            width: 1.0,
            color: widget.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            width: 1.0,
            color: widget.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColorConstant.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColorConstant.redColor,
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
            fontSize: 16, color: AppColorConstant.inputHintColor),
      ),
      onChanged: (value) {
        setState(() {
          widget.controller.text = value.toString();
        });
        if (widget.onChange != null) {
          widget.onChange!(value.toString());
        }
      },
    );
  }
}
