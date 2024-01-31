import 'package:flutter/material.dart';

class EditButton extends StatefulWidget {
  final Function() onTap;
  const EditButton({super.key, required this.onTap});

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: widget.onTap,
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.edit,
            size: 20.0,
          ),
        ));
  }
}
