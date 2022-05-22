import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/classes/converter.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/widgets/showError.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

bool? isFruit;
String? itemID;

class EditingScreen extends StatefulWidget {
  const EditingScreen({Key? key}) : super(key: key);

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController benefits = TextEditingController();
  bool playing = true;
  final theSource = AudioSource.microphone;
  String? audioBase;
  XFile? image;
  ImagePicker imagePicker = ImagePicker();
  Codec _codec = Codec.aacMP4;
  String? _mPath;
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  Uint8List? imageBytes;
  String? imageBase;
  Future<dynamic>? item;
  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
  }

  Future<void> record() async {
    await _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
      });
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    item = isFruit!
        ? API.getFruit(user!.userID, itemID!)
        : API.getVegetable(user!.userID, itemID!);

    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.2,
              child: Stack(
                children: [
                  SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Image.asset(
                        "assets/top.png",
                        fit: BoxFit.fill,
                      )),
                  SafeArea(
                    child: Center(
                      child: Container(
                        color: Colors.green.withOpacity(0.6),
                        height: size.height,
                        child: Padding(
                          padding: EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: size.width * 0.1,
                              ),
                              Text(
                                "Editting Page",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<dynamic>(
                future: item,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  maxRadius: 90,
                                  backgroundColor:
                                      Colors.green.withOpacity(0.8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: image == null
                                        ? Image.network(
                                            url +
                                                "/" +
                                                snapshot.data!["image_url"]
                                                    .toString()
                                                    .replaceAll("\/", "/"),
                                          )
                                        : Image.memory(imageBytes!),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                maxRadius: 30,
                                child: IconButton(
                                    onPressed: () async {
                                      image = await imagePicker.pickImage(
                                          source: ImageSource.gallery);
                                      imageBytes = await image!.readAsBytes();
                                      imageBase =
                                          await Converter.imageTobase(image!);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.edit_sharp,
                                      size: 28,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green.withOpacity(0.8)),
                              child: TextField(
                                controller: name,
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintText: snapshot.data!["name"],
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.9)),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green.withOpacity(0.8)),
                              child: TextField(
                                controller: benefits,
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintText: snapshot.data!["benefits"],
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.9)),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Text(
                                      "Benefites",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _mPlayer!.isPlaying
                                  ? IconButton(
                                      onPressed: () {
                                        playing = false;
                                        setState(() {});
                                        stopPlayer();
                                      },
                                      icon: Icon(
                                        Icons.pause_circle,
                                        size: 50,
                                        color: Colors.red,
                                      ))
                                  : IconButton(
                                      onPressed: () async {
                                        Future<void> play() async {
                                          assert(_mPlayerIsInited &&
                                              _mRecorder!.isStopped &&
                                              _mPlayer!.isStopped);
                                          try {
                                            await _mPlayer!
                                                .startPlayer(
                                                    codec: Codec.aacMP4,
                                                    fromURI: url +
                                                        "/" +
                                                        snapshot
                                                            .data!["audio_url"]
                                                            .toString()
                                                            .replaceAll(
                                                                "\/", "/"),

                                                    whenFinished: () {
                                                      setState(() {});
                                                    })
                                                .then((value) {
                                              setState(() {});
                                            });
                                          } catch (e) {}
                                        }

                                        playing = true;
                                        setState(() {});
                                        await play();
                                      },
                                      icon: Icon(
                                        Icons.play_circle,
                                        size: 50,
                                        color: Colors.green,
                                      )),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.green.withOpacity(0.8),
                                    maxRadius: 30,
                                    child: IconButton(
                                        onPressed: () async {
                                          if (_mRecorderIsInited) {
                                            if (!_mRecorder!.isRecording) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Listening")));
                                              try {
                                                _mPath =
                                                    (await getApplicationDocumentsDirectory())
                                                            .path +
                                                        "/temp.mp4";
                                                await record();
                                              } catch (e) {
                                                print(e);
                                              }
                                            } else {
                                              try {
                                                await stopRecorder();
                                              } catch (e) {
                                                print(e);
                                              }
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text("Recoreded Audio"),
                                                    content: StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return SizedBox(
                                                          width: size.width,
                                                          height:
                                                              size.height * 0.1,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              _mPlayer!
                                                                      .isPlaying
                                                                  ? Text(
                                                                      "Playing")
                                                                  : Text(
                                                                      "Stopped"),
                                                              _mPlayer!
                                                                      .isPlaying
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        playing =
                                                                            false;
                                                                        setState(
                                                                            () {});
                                                                        stopPlayer();
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .pause_circle,
                                                                        color: Colors
                                                                            .red,
                                                                      ))
                                                                  : IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        Future<void>
                                                                            play() async {
                                                                          assert(_mPlayerIsInited &&
                                                                              _mRecorder!.isStopped &&
                                                                              _mPlayer!.isStopped);
                                                                          await _mPlayer!
                                                                              .startPlayer(
                                                                                  fromURI: _mPath,
                                                                                  whenFinished: () {
                                                                                    setState(() {});
                                                                                  })
                                                                              .then((value) {
                                                                            setState(() {});
                                                                          });
                                                                        }

                                                                        playing =
                                                                            true;
                                                                        setState(
                                                                            () {});
                                                                        await play();
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .play_circle,
                                                                        color: Colors
                                                                            .green,
                                                                      ))
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          if (_mPlayer!
                                                              .isPlaying) {
                                                            await _mPlayer!
                                                                .stopPlayer();
                                                          }
                                                          setState(() {
                                                            audioBase = Converter
                                                                .getBase64FormateFile(
                                                                    _mPath!);

                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Text("Confirm"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ).then((value) {});
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_mRecorder!.isRecording
                                        ? "Click to stop recording"
                                        : "Click to start recording"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width,
                            child: Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () async {
                                    if (name.text.isNotEmpty ||
                                        benefits.text.isNotEmpty ||
                                        imageBase != null ||
                                        audioBase != null) {
                                      showDialog(
                                          context: context,
                                          builder: (newContext) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Are you sure you want to edit ?"),
                                              content:Row(
                                                
                                                children: [
                                                Container(
                                                   width: size.width*0.3,
                                                            height: size.height*0.1,
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.all(6),
                                                            decoration: BoxDecoration(

                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                  child: TextButton(
                                                      onPressed: () async {
                                                        if (isFruit!) {
                                                          if (name
                                                              .text.isNotEmpty) {
                                                            String rep = await API
                                                                .editFruitName(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    name.text);
                                                          }
                                                          if (benefits
                                                              .text.isNotEmpty) {
                                                            String rep = await API
                                                                .editFruitBenefits(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    benefits
                                                                        .text);
                                                          }
                                                          if (imageBase != null) {
                                                            String rep = await API
                                                                .editFruitImage(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    imageBase!);
                                                          }
                                                          if (audioBase != null) {
                                                            String rep = await API
                                                                .editVegetableAudio(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    audioBase!);
                                                          }
                                                        } else {
                                                          if (name
                                                              .text.isNotEmpty) {
                                                            String rep = await API
                                                                .editVegetableName(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    name.text);
                                                          }
                                                          if (benefits
                                                              .text.isNotEmpty) {
                                                            String rep = await API
                                                                .editVegetableBenefits(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    benefits
                                                                        .text);
                                                          }
                                                          if (imageBase != null) {
                                                            String rep = await API
                                                                .editVegetableImage(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    imageBase!);
                                                          }
                                                          if (audioBase != null) {
                                                            String rep = await API
                                                                .editVegetableAudio(
                                                                    user!.userID,
                                                                    itemID!,
                                                                    audioBase!);
                                                          }
                                                        }

                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Yes",
                                                      style: TextStyle(color: Colors.white),
                                                      )),
                                                ),
                                                Container(
                                                   width: size.width*0.3,
                                                            height: size.height*0.1,
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.all(6),
                                                            decoration: BoxDecoration(

                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Cancel",
                                                                                                            style: TextStyle(color: Colors.white),
)),
                                                )
                                              ],)
                                            );
                                          }).then((value) {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      showMessage("please fill required fields",
                                          context);
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: size.height * 0.05,
                                      margin: EdgeInsets.all(8),
                                      child: Center(child: Text("Submit"))),
                                )),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      height: size.height * 0.05,
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: EdgeInsets.all(8),
                                      child: Center(child: Text("Cencel"))),
                                ))
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  }
                  return Center(
                    child: Text("No internet connection"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
