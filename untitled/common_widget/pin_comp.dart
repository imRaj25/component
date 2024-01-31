import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinComp extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  const PinComp({required this.onChanged, this.onCompleted, super.key});

  @override
  State<PinComp> createState() => _PinCompState();
}

class _PinCompState extends State<PinComp> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: AppColorConstant.blackColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: const Color.fromRGBO(123, 63, 0, 0.6)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: pinController,
      focusNode: focusNode,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      defaultPinTheme: defaultPinTheme,
      separatorBuilder: (index) => const SizedBox(width: 8),
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: AppColorConstant.primaryDarkColor,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColorConstant.primaryDarkColor),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: AppColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: AppColorConstant.primaryDarkColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
    );
  }
}
