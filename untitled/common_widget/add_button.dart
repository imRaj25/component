import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';

class AddButton extends StatefulWidget {
  final Function() onTap;
  const AddButton({super.key, required this.onTap});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: widget.onTap,
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Add",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColorConstant.primaryColor,
            ),
          ),
        ));
  }
}
