import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';

enum StatusEnum { defaultStatus, warning, info, success }

class CustomAlertDialog {
  static Future<bool?> showMyDialog(
    String title,
    String mssg,
    BuildContext context, {
    String? okButtonName,
    StatusEnum? statusEnum,
    Function()? onOkClick,
    Function()? onCancelClick,
  }) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertBox(
          title: title,
          description: mssg,
          okCancelButton: false,
          okButtonName: okButtonName ?? "Ok",
          statusEnum: statusEnum,
          onOkClick: onOkClick,
          onCancelClick: onCancelClick,
        );
      },
    );
  }

  static Future<bool?> showDialogWithCancel(
    String title,
    String mssg,
    BuildContext context, {
    String? okButtonName,
    String? cancelButtonName,
    StatusEnum? statusEnum,
    Function()? onOkClick,
    Function()? onCancelClick,
  }) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertBox(
          title: title,
          description: mssg,
          okCancelButton: true,
          okButtonName: okButtonName ?? "Ok",
          cancelButtonName: cancelButtonName ?? "Cancel",
          statusEnum: statusEnum,
          onOkClick: onOkClick,
          onCancelClick: onCancelClick,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class CustomAlertBox extends StatefulWidget {
  final String title;
  final String description;
  final bool okCancelButton;
  String? okButtonName;
  String? cancelButtonName;
  StatusEnum? statusEnum;
  Function()? onOkClick;
  Function()? onCancelClick;
  CustomAlertBox(
      {super.key,
      required this.title,
      required this.description,
      required this.okCancelButton,
      this.okButtonName = "Ok",
      this.cancelButtonName = "Cancel",
      this.onOkClick,
      this.onCancelClick,
      this.statusEnum = StatusEnum.defaultStatus});

  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Color getColor() {
    // if (StatusEnum.info == widget.statusEnum ||
    //     StatusEnum.defaultStatus == widget.statusEnum) {
    //   return Colors.blue;
    // } else if (StatusEnum.success == widget.statusEnum) {
    //   return Colors.green;
    // }
    // return Colors.amber;
    return Colors.black;
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              left: 20.0, top: 30.0, right: 20.0, bottom: 20.0),
          margin: const EdgeInsets.only(top: 30.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  color: getColor(),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                // textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              // Actions button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.okCancelButton == true
                      ? Expanded(
                          flex: 1,
                          child:
                              _buildCancelButton(context, widget.onCancelClick),
                        )
                      : Container(),
                  Expanded(
                      flex: 1,
                      child: _buildOkButton(context, widget.onOkClick)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30.0),
              ),
              child: _buildStatusIcon(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIcon(context) {
    if (StatusEnum.success == widget.statusEnum) {
      return Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 34.0,
        ),
      );
    } else if (StatusEnum.info == widget.statusEnum) {
      return Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Icon(
          Icons.info,
          color: Colors.blue,
          size: 34.0,
        ),
      );
    } else if (StatusEnum.warning == widget.statusEnum) {
      return Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Icon(
          Icons.warning,
          color: Colors.amber,
          size: 34.0,
        ),
      );
    } else {
      return Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Icon(
          Icons.info,
          color: Colors.blue,
          size: 34.0,
        ),
      );
    }
  }

  TextButton _buildCancelButton(context, Function()? onCancelClick) {
    return TextButton(
      child: Text(
        widget.cancelButtonName!,
        style: const TextStyle(
          fontSize: // CHECKING TABLET OR MOBILE
              14.0,
        ),
      ),
      onPressed: () {
        Navigator.pop(context, false);
        if (onCancelClick != null) {
          onCancelClick();
        }
      },
    );
  }

  ElevatedButton _buildOkButton(context, Function()? onOkClick) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color(0xFFdbdbdb);
            }
            return AppColorConstant
                .primaryColor; // Use the component's default.
          },
        ),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context, true);
        if (onOkClick != null) {
          onOkClick();
        }
      },
      child: Text(
        widget.okButtonName!,
        style: const TextStyle(
          fontSize: // CHECKING TABLET OR MOBILE
              14.0,
        ),
      ),
    );
  }
}
