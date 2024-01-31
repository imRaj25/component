import 'package:flutter/material.dart';

class DeleteButton extends StatefulWidget {
  final Function() onTap;
  const DeleteButton({super.key, required this.onTap});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: widget.onTap,
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 20.0,
          ),
        ));
  }
}
