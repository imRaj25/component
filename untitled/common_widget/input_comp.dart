import 'package:flutter/services.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

class InputComp extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool isReadOnly;
  final String hint;
  final double borderRadius;
  final int maxLine;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool isPassword;
  final TextInputType keyboardType;
  final Color borderColor;
  final Icon? prefixIcon;
  final int? maxLength;
  final String? defaultValue;
  final Function()? onTap;
  final Function()? onChange;
  final TextCapitalization? textCapitalization;

  const InputComp(
      {this.validator,
      required this.controller,
      required this.hint,
      this.isReadOnly = false,
      this.borderRadius = 10.0,
      this.suffixIcon,
      this.prefix,
      this.defaultValue,
      this.maxLine = 1,
      this.maxLength,
      this.prefixIcon,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.borderColor = AppColorConstant.inputBorderColor,
      super.key,
      this.onTap,
      this.onChange,
      this.textCapitalization = TextCapitalization.none});

  @override
  State<InputComp> createState() => _InputCompState();
}

class _InputCompState extends State<InputComp> {
  bool obsecureText = false;
  @override
  void initState() {
    obsecureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obsecureText,
      readOnly: widget.isReadOnly,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLine,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization!,
      obscuringCharacter: '*',
      inputFormatters: widget.keyboardType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        hintText: widget.hint,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        fillColor: const Color(0xffFFFFFF),
        filled: true,
        hintStyle: const TextStyle(
            fontSize: 16, color: AppColorConstant.inputHintColor),
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
      ),
      onTap: widget.onTap,
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!();
        }
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
