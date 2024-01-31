import 'package:flutter/material.dart';

class EmptyStatusWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final String mssg;
  const EmptyStatusWidget(
      {super.key,
      required this.child,
      required this.title,
      required this.mssg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 175,
          width: 175,
          child: child,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 18.0),
        Text(
          mssg,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xff5E5E5E),
          ),
        )
      ],
    );
  }
}
