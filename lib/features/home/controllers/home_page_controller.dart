import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../splitter/views/dialogs/permission_denied_dialog.dart';
import '../../splitter/views/pages/splitter_page.dart';

class HomePageController extends GetxController {
  /// Audio Picker
  Future<void> pickLocalFiles(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['mp3'],
        type: FileType.custom,
        allowCompression: false,
        dialogTitle: 'Pick Audio File',
      );
      if (result != null) {
        String fileName = result.files.single.name;
        String? fileIdentifier = result.files.single.identifier;
        String? directoryPath = await FilePicker.platform.getDirectoryPath();

        Directory directory = Directory.fromUri(Uri.directory(fileIdentifier!));

        String? finalFileName = '$directoryPath/$fileName';
        String? absoluteFilePath = directory.path;

        if (kDebugMode) print("The absolute path is: $absoluteFilePath");
        if (kDebugMode) print("The filename is: $finalFileName");

        Get.to(() => SplitterPage(
              filePath: finalFileName,
              songName: fileName,
            ));
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      if (e.code == 'read_external_storage_denied') {
        Get.dialog(const AudioFilePickerPermissionDenied());
      } else {}
    }
  }

  /// Buy Premium Button

  /// Load Recent Files

}
