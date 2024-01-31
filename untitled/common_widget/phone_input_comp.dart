import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneInputComp extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(PhoneNumber?)? validator;
  final void Function(Country?)? onCountryChange;
  final String hint;
  final bool isReadOnly;
  const PhoneInputComp(
      {this.validator,
      required this.controller,
      required this.hint,
      this.isReadOnly = false,
      required this.onCountryChange,
      super.key});

  @override
  State<PhoneInputComp> createState() => _PhoneInputCompState();
}

class _PhoneInputCompState extends State<PhoneInputComp> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      dropdownIconPosition: IconPosition.trailing,
      showCountryFlag: false,
      initialCountryCode: "IN",
      enabled: !widget.isReadOnly,
      flagsButtonPadding: const EdgeInsets.only(left: 12.0, right: 8.0),
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        fillColor: const Color(0xffFFFFFF),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColorConstant.inputBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColorConstant.inputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColorConstant.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColorConstant.redColor,
          ),
        ),
        hintText: widget.hint,
      ),
      languageCode: "en",
      onCountryChanged: widget.onCountryChange,
      validator: widget.validator,
    );
  }
}
