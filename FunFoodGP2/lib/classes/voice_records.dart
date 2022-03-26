import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class Sounds {


  //التسجيل الصوتي 
  /* 

اولا نتاكد من ان الصلاحيات للتخزين و التسجيل الصوتي متاحة

getApplicationDocumentsDirectory() 
تعيد لنا مسار التطبيق على الجهاز




  */
  Future<dynamic> record() async {
    Permission micro = Permission.microphone;
    Permission storage = Permission.storage;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    if (await micro.request() == PermissionStatus.granted &&
        await storage.request() == PermissionStatus.granted) {
      final _recordingSession = FlutterSoundRecorder();
      // نبدأ ب اوبن ثم ال ستارت 
      await _recordingSession.openRecorder();
      await _recordingSession.startRecorder(
          codec: Codec.aacMP4,
          toFile:
              (await getApplicationDocumentsDirectory()).path + "/temp.aac");
      await Future.delayed(Duration(seconds: 10));
      await _recordingSession.stopRecorder();
    } else {
      return -1;
    }
  }

  Future<void> convert() async {
    File file = File.fromUri(Uri.parse(
        (await getApplicationDocumentsDirectory()).path + "/temp.aac"));
    final unit8List = await file.readAsBytes();
    final byteData = unit8List.buffer.asByteData(); //

    print(unit8List);
  }

  Future<void> play() async {
    FlutterSoundPlayer flutterSoundPlayer = FlutterSoundPlayer();
    await flutterSoundPlayer.openPlayer();
    await flutterSoundPlayer.startPlayer(
        fromURI: (await getApplicationDocumentsDirectory()).path + "/temp");
  }
}
