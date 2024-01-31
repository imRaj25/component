import 'package:haatinhandseller/common_widget/dropdoun_type.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

class CustomDropdownSearch extends StatefulWidget {
  final String? Function(dynamic)? validator;
  final Function(dynamic)? onChange;
  final List<DropdownType> list;
  final double menuHeight;
  final TextEditingController controller;
  final Color borderColor;
  final double borderRadius;
  final String hint;
  const CustomDropdownSearch(
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
  State<CustomDropdownSearch> createState() => _CustomDropdownSearchState();
}

class _CustomDropdownSearchState extends State<CustomDropdownSearch> {
  final TextEditingController textController = TextEditingController();
  DropdownType? selectedIcon;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<DropdownType>(
      controller: textController,
      enableFilter: true,
      requestFocusOnTap: true,
      menuHeight: widget.menuHeight,
      width: MediaQuery.of(context).size.width * 0.92,
      leadingIcon: const Icon(Icons.search),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
        fillColor: Colors.white,
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
        hintStyle: const TextStyle(
            fontSize: 16, color: AppColorConstant.inputHintColor),
      ),
      onSelected: (DropdownType? icon) {
        widget.controller.text = icon!.id;
        setState(() {
          selectedIcon = icon;
        });
      },
      hintText: widget.hint,
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<DropdownType>>(
        (DropdownType icon) {
          return DropdownMenuEntry<DropdownType>(
            value: icon,
            label: icon.label,
            style: MenuItemButton.styleFrom(
              backgroundColor: Colors.white,
            ),
          );
        },
      ).toList(),
    );
  }
}
