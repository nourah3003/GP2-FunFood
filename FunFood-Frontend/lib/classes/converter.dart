import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Converter {
  static Future<String> imageTobase(XFile image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);

  }

 static String getBase64FormateFile(String path) {
    File file = File(path);
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }
}
