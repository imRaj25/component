import 'package:flutter/material.dart';

class ErrorStatusWidget extends StatelessWidget {
  final String mssg;
  const ErrorStatusWidget({super.key, required this.mssg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(mssg),
    );
  }
}
