import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

///
/// Created by Sunil Kumar on 22-01-2021 08:29 PM.
///

class DocumentChooser extends StatelessWidget {
  final String? title;

  const DocumentChooser({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 22,
          ),
          Text(
            title ?? S.of(context).chooseFromASource,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          DefaultTextStyle(
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _chooseDocument(context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.note_add_outlined,
                          size: 32,
                        ),
                        Text("Document")
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 38),
                GestureDetector(
                  onTap: () => _chooseImage(ImageSource.camera, context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.camera,
                          size: 32,
                        ),
                        Text(S.of(context).camera)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 38,
                ),
                GestureDetector(
                  onTap: () => _chooseImage(ImageSource.gallery, context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.photo_library_rounded,
                          size: 32,
                        ),
                        Text(S.of(context).gallery)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 0, color: Colors.grey),
          TextButton(
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: Center(child: Text(S.of(context).cancel)),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _chooseDocument(BuildContext context) {
    FilePicker.platform.pickFiles(
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
      ],
      type: FileType.custom,
    ).then((value) {
      if (value != null && value.files.isNotEmpty) {
        Navigator.pop(context, File(value.files.first.path!));
      }
    });
  }

  _chooseImage(ImageSource source, BuildContext context) {
    ImagePicker()
        .pickImage(
      source: source,
    )
        .then((file) {
      if (file != null && file.path.isNotEmpty) {
        ImageCropper().cropImage(
          sourcePath: file.path,
          maxWidth: 500,
          maxHeight: 500,
          cropStyle: CropStyle.rectangle,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Your Image',
              toolbarColor: Get.theme.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              // lockAspectRatio: true,
            ),
            IOSUiSettings(
                minimumAspectRatio: 1.0,
                title: S.of(context).cropYourImage,
                aspectRatioLockEnabled: true,
                showCancelConfirmationDialog: true),
          ],
        ).then((CroppedFile? value) {
          if (value != null && value.path.isNotEmpty) {
            Navigator.pop(context, File(value.path));
          }
        });
      }
    }).catchError((error) {
      SnackBarHelper.show(S.of(context).pleaseAllowPermissionToUploadImage);
    });
  }
}
