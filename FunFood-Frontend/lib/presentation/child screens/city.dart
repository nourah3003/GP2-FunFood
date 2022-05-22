import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

class MyCityScreen extends StatefulWidget {
  const MyCityScreen({Key? key}) : super(key: key);

  @override
  State<MyCityScreen> createState() => _MyCityScreenState();
}

class _MyCityScreenState extends State<MyCityScreen>
    with TickerProviderStateMixin {
  Future<String>? coin;
  Future<List<dynamic>?>? houses;
  ConfettiController? _controllerCenter;
  Future<String>? coinsCount; // counter of coins
  AudioCache musicCache = AudioCache(prefix: "assets/");
  late AnimationController controller;
  late Animation<num> alpha;
  late AnimationController birdsController;
  late Animation<num> birdsAnimation;
  AudioPlayer? instance;
  String asset = "assets/airplane.png"; // the Animation airplane in the city
  String birds = "assets/birds.gif";  // the Animation birds in the city
  @override
  void initState() {
    controller = AnimationController(
        reverseDuration: const Duration(seconds: 20),
        duration: const Duration(seconds: 20),
        vsync: this)
      ..addListener(() {
        if (controller.isCompleted) {
          if (asset == "assets/airplane.png") {
            asset = "assets/airplane FLIP.png";
          } else {
            asset = "assets/airplane.png";
          }
          setState(() {});
          controller.reverse().then((value) {
            if (asset == "assets/airplane.png") {
              asset = "assets/airplane FLIP.png";
            } else {
              asset = "assets/airplane.png";
            }
            setState(() {});
            controller.forward();
          });
        }
      });
    alpha = Tween(begin: -0.3, end: 1.4).animate(controller);



    controller.forward();
    //birds
    birdsController = AnimationController(
        reverseDuration: const Duration(seconds: 20),
        duration: const Duration(seconds: 20),
        vsync: this)
      ..addListener(() {
        if (birdsController.isCompleted) {
          if (birds == "assets/birds.gif") {
            birds = "assets/birds flip.gif";
          } else {
            birds = "assets/birds.gif";
          }
          setState(() {});
          birdsController.reverse().then((value) {
            if (birds == "assets/birds.gif") {
              birds = "assets/birds flip.gif";
            } else {
              birds = "assets/birds.gif";
            }
            setState(() {});
            birdsController.forward();
          });
        }
      });
    birdsAnimation = Tween(begin: -0.3, end: 1.4).animate(controller);
    birdsController.forward();
    coin = API.getCoins(user!.userID);
    houses = API.getHouses(user!.userID);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    birdsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //size of items in city
                Expanded(
                  flex: 9,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Image.asset(
                          "assets/ground.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: size.height,
                        width: size.width * 0.1,
                        child: Image.asset("assets/road hor.png",
                            fit: BoxFit.fitHeight),
                      ),
                      Positioned(
                        top: size.height * 0.32,
                        child: SizedBox(
                          height: size.height * 0.05,
                          width: size.width,
                          child: Image.asset(
                            "assets/road ver.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.65,
                        child: SizedBox(
                          height: size.height * 0.05,
                          width: size.width,
                          child: Image.asset(
                            "assets/road ver.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      DragTarget<String>(onAccept: (data) async {
                        if (data == "assets/park.png") {
                          final rep = (await API.addPalace(user!.userID, data));
                          if (rep["code"].toString() == "2") {
                            _controllerCenter!.play();
                            instance = await musicCache.play("gj.mp3");
                            showMessage(
                                "You completed a whole city ! Good Job!",
                                context);
                          } else if (rep["code"] == "1") {
                            showMessage(
                                "You built a whole park ! Good Job!", context); // message appear when child add park
                          } else if (rep["code"] == "0") {
                            showMessage(
                                "You don't have enough coins yet, solve a quiz to earn more!",
                                context);
                          }
                        } else {
                          String rep =
                              (await API.addHouse(user!.userID, data))["code"] //
                                  .toString();
                          if (rep == "1") {
                            showMessage(
                                "You built a whole house ! Good Job!", context);
                            _controllerCenter!.play();
                          } else if (rep == "0") { //when child try to add house without complete 5 servings
                            showMessage("Please, complete eating five servings",
                                context);
                          } else if (rep == "2") {
                            showMessage(
                                "You completed a whole city ! Good Job!",
                                context);
                          }
                        }
                        houses = API.getHouses(user!.userID);
                        coin = API.getCoins(user!.userID);
                        setState(() {});
                      }, builder: (context, candidateData, rejectedData) {
                        return FutureBuilder<List<dynamic>?>(
                            future: houses,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Center(
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      height: size.height * 0.95,
                                      width: size.width,
                                      child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 28,
                                                  mainAxisSpacing: 12),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return snapshot.data![index]
                                                        ["image_url"] !=
                                                    "assets/park.png"
                                                ? Container(
                                                    padding: const EdgeInsets.all(8),
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                      snapshot.data![index]
                                                          ["image_url"],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                : Container(
                                                    padding: const EdgeInsets.all(25),
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                      snapshot.data![index]
                                                          ["image_url"],
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                          }),
                                    ),
                                  );
                                }
                              }
                              return Container();
                            });
                      }),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Positioned(
                                left: size.width * alpha.value,
                                bottom: size.width * alpha.value,
                                child: SizedBox(
                                    width: size.width * 0.2,
                                    height: size.height * 0.1,
                                    child: Image.asset(asset)));
                          }),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Positioned(
                                left: size.width * alpha.value,
                                bottom: size.width * 1.4 * alpha.value,
                                child: SizedBox(
                                    width: size.width * 0.2,
                                    height: size.height * 0.1,
                                    child: Image.asset(asset)));
                          }),
                      AnimatedBuilder(
                          animation: birdsController,
                          builder: (context, child) {
                            return Positioned(
                                left: size.width * alpha.value,
                                top: 100,
                                child: SizedBox(
                                    width: size.width * 0.2,
                                    height: size.height * 0.2,
                                    child: Image.asset(birds)));
                          }),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Positioned(
                                left: size.width * alpha.value,
                                top: 500,
                                child: SizedBox(
                                    width: size.width * 0.3,
                                    height: size.height * 0.3,
                                    child: Image.asset(birds)));
                          }),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Draggable(
                            data: "assets/factory.png", //function of drag the items in city
                            onDragStarted: () {},
                            feedback: SizedBox(
                              width: size.width * 0.2,
                              height: size.height * 0.15,
                              child: Image.asset(
                                "assets/factory.png",
                              ),
                            ),
                            child: Image.asset(
                              "assets/factory.png",
                              width: size.width * 0.2,
                              height: size.height * 0.2,
                            )),
                        Draggable(
                            data: "assets/house1.png",
                            onDragStarted: () {},
                            feedback: SizedBox(
                              width: size.width * 0.2,
                              height: size.height * 0.15,
                              child: Image.asset(
                                "assets/house1.png",
                              ),
                            ),
                            child: Image.asset(
                              "assets/house1.png",
                              width: size.width * 0.2,
                              height: size.height * 0.2,
                            )),
                        Draggable(
                            data: "assets/park.png",
                            feedback: SizedBox(
                              width: size.width * 0.2,
                              height: size.height * 0.1,
                              child: Image.asset(
                                "assets/park.png",
                                width: size.width * 0.2,
                                height: size.height * 0.2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/park.png",
                                  width: size.width * 0.2,
                                  height: size.height * 0.2,
                                ),
                                Image.asset(
                                  "assets/coins.png",
                                  width: size.width * 0.1,
                                  height: size.height * 0.1,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          Container(
                            width: size.width * 0.3,
                            decoration: const BoxDecoration(),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future: coin,
                                      builder: (contex, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data.toString(),
                                                style:const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold));
                                          }
                                        }
                                        return const Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                  Image.asset("assets/coins.png"),
                                ]),
                          ),
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
