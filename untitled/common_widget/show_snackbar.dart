import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String message,
    bool isError = false}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          isError ? Icons.error : Icons.check_circle,
          color: isError ? Colors.red : Colors.green,
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon:
              Icon(Icons.close, color: !isError ? Colors.white : Colors.black),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ],
    ),
    backgroundColor: isError ? Colors.red : Colors.grey[800],
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
