import 'dart:developer';
import 'dart:io';

import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haatinhandseller/models/file_model.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
FileModel? file;
Future<dynamic> _imgFromCamera() async {
  try {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    file = FileModel(
        file: File(pickedFile!.path), key: "file", name: pickedFile.name);
    return file;
  } on PlatformException catch (e) {
    log('Failed to pick image: $e');
  }
  return null;
}

Future<dynamic> _imgFromGallery() async {
  try {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    file = FileModel(
        file: File(pickedFile!.path), key: "file", name: pickedFile.name);
    return file;
  } on PlatformException catch (e) {
    log('Failed to pick image: $e');
  }
  return null;
}

Future<dynamic> _multipleImgFromGallery() async {
  try {
    List<FileModel> imageList = [];
    List<XFile>? pickedFiles = await _picker.pickMultiImage(imageQuality: 50);
    for (var file in pickedFiles) {
      imageList
          .add(FileModel(file: File(file.path), key: "files", name: file.name));
    }
    return imageList;
  } on PlatformException catch (e) {
    log('Failed to pick image: $e');
  }
  return null;
}

callImagePicker(
    {required BuildContext context,
    bool? isMultiple=false,
    required Function(dynamic) onImagePicked}) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: 145.0,
            color: AppColorConstant.whiteColor,
            // padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.photo_camera),
                    onPressed: () async {
                      var imageFile = await _imgFromCamera();
                      if (imageFile != null) {
                        onImagePicked(imageFile);
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const VerticalDivider(
                  thickness: 1.5,
                  color: AppColorConstant.normalGrey,
                ),
                CircleAvatar(
                  radius: 40,
                  child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.photo_library),
                      onPressed: () async {
                        if (isMultiple!) {
                          List<FileModel> imageList =
                              await _multipleImgFromGallery();
                          onImagePicked(imageList);
                        } else {
                          var imageFile = await _imgFromGallery();
                          if (imageFile != null) {
                            onImagePicked(imageFile);
                          }
                        }
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      });
}
