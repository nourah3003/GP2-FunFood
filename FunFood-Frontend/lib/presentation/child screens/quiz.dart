import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

import '../../classes/api.dart';
import '../../main.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  List<Map<String, dynamic>> messages = [];
  Future<String>? coin;
  ConfettiController? confettiController;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache cashe = AudioCache(prefix: "assets/");
  DetectIntentResponse? response;
  TextEditingController textEditingController = TextEditingController();

  Future<void> sendMessage(String value, BuildContext context) async {
    try {
      response = await dialogFlowtter!.detectIntent(
        queryInput: QueryInput(
          text: TextInput(
            text: value,
            languageCode: "en-US",
          ),
        ),
      );
      print(response!.queryResult!);
      messages.add({"code": "child", "message": value});
      messages.add(response!.queryResult!.fulfillmentMessages!.first.payload!);
      animationAndSound();
      setState(() {});
    } catch (e) {
      showMessage("an error occured", context);
      print(e);
    }
  }

  void animationAndSound() async {
    if (response!.queryResult!.fulfillmentMessages!.first.payload!["code"]
            .toString() ==
        "welcome") {
      confettiController!.play();
      //play animation
      //play welcome sound
    } else if (response!
            .queryResult!.fulfillmentMessages!.first.payload!["code"]
            .toString() ==
        "right") {
      await API.addCoins(user!.userID);
      setState(() {});
      confettiController!.play();
      await cashe.play("gj.mp3");
    } else if (response!
            .queryResult!.fulfillmentMessages!.first.payload!["code"]
            .toString() ==
        "wrong") {
      //play animation
      //play welcome sound

      await cashe.play("tg.mp4");
    } else if (response!
            .queryResult!.fulfillmentMessages!.first.payload!["code"]
            .toString() ==
        "done") {
      //play animation
      //play welcome sound
      confettiController!.play();
      await cashe.play("wd.mp4");
    }
  }

  DialogAuthCredentials? credentials;
  DialogFlowtter? instance;
  DialogFlowtter? dialogFlowtter;
  String jsonPath = "assets/fun_food_dialog.json";
  QueryInput? queryInput;
  @override
  void initState() {
    coin = API.getCoins(user!.userID);
    confettiController = ConfettiController(duration: Duration(seconds: 4));
    Future.sync(() async {
      credentials = await DialogAuthCredentials.fromFile(jsonPath);
      instance = DialogFlowtter(
        credentials: credentials!,
      );
      dialogFlowtter = DialogFlowtter(
        credentials: credentials!,
        sessionId: TimeOfDay.now().toString(),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    instance!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: Stack(
        children: [
          messages.isNotEmpty
              ? Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: messages.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            int itemCount = messages.length;
                            int reversedIndex = itemCount - 1 - index;
                            if (messages[index]["code"] == "child") {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(18),
                                    margin: EdgeInsets.all(18),
                                    width: size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Text(
                                          messages[reversedIndex]["message"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 23),
                                        ),
                                        messages[reversedIndex]["url"] == null
                                            ? Container()
                                            : Image.asset(
                                                messages[reversedIndex]["url"])
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(18),
                                    margin: EdgeInsets.all(18),
                                    width: size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.9),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Text(
                                          messages[reversedIndex]["message"],
                                          style: TextStyle(fontSize: 23),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          })),
                           SizedBox(
                    width: size.width,
                    height: size.height * 0.1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            autocorrect: true,
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: "write your message here !"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                if (textEditingController.text.isNotEmpty) {
                                  sendMessage(
                                      textEditingController.text, context);
                                  textEditingController.clear();
                                } else {
                                  showMessage("Your message is empty", context);
                                }
                              },
                              icon: const Icon(Icons.send_rounded)),
                        )
                      ],
                    ),
                  )
                 
                ])
              : SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("assets/robot.webp"),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(18.0),
                          child:
                             const Text("Start the conversation by saying Hi or Hello!",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                              
                              ),
                              ),
                        ),
                         SizedBox(
                    width: size.width,
                    height: size.height * 0.1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            autocorrect: true,
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: "write your message here !"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                if (textEditingController.text.isNotEmpty) {
                                  sendMessage(
                                      textEditingController.text, context);
                                  textEditingController.clear();
                                } else {
                                  showMessage("Your message is empty", context);
                                }
                              },
                              icon: const Icon(Icons.send_rounded)),
                        )
                      ],
                    ),
                  )
                      ],
                    ),
                ),
              ),
       
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  color: Colors.green.withOpacity(0.6),
                  width: size.width,
                  height: size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      SizedBox(
                        width: size.width * 0.27,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                  future: coin,
                                  builder: (contex, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return Text(snapshot.data.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold));
                                      }
                                    }
                                    return Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                              Image.asset(
                                "assets/coins.png",
                                height: size.height * 0.08,
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              )),
          ConfettiWidget(
            confettiController: confettiController!,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            numberOfParticles: 20,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          )
        ],
      ),
    );
  }
}
