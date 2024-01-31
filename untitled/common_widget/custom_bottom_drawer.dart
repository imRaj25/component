import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBottomDrawer extends StatefulWidget {
  double height;
  Widget child;
  final Function(double) onDragUpdate;
  final Function(double) onDragUEnd;
  CustomBottomDrawer({
    super.key,
    this.height = 300,
    required this.child,
    required this.onDragUpdate,
    required this.onDragUEnd,
  });

  @override
  State<CustomBottomDrawer> createState() => _CustomBottomDrawerState();
}

class _CustomBottomDrawerState extends State<CustomBottomDrawer> {
  double dragYSum = 0;
  bool dragStarted = false;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      width: w,
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 2, top: 0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 247, 247),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: AppColorConstant.greyColor,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0),
            ),
          ]),
      child: Column(
        children: [
          GestureDetector(
            onVerticalDragStart: (details) {
              dragYSum = 0;
              dragStarted = true;
              setState(() {});
              widget.onDragUpdate(dragYSum);
            },
            onVerticalDragUpdate: (details) {
              if (details.localPosition.dy < 0) {
                return;
              }
              dragYSum = details.localPosition.dy;
              widget.onDragUpdate(dragYSum);
            },
            onVerticalDragEnd: (details) {
              dragStarted = false;
              widget.onDragUEnd(dragYSum);
              dragYSum = 0;
              setState(() {});
            },
            child: Container(
              height: 20.0,
              width: w,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
              child: Center(
                child: Container(
                  height: 5.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                    color: dragStarted
                        ? AppColorConstant.primaryColor
                        : AppColorConstant.greyColor,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
          ),
          widget.child
        ],
      ),
    );
  }
}
