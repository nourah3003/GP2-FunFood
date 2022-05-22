import 'package:flutter/material.dart';
import 'package:fun_food/classes/storage.dart';
import 'package:fun_food/presentation/child%20screens/city.dart';
import 'package:fun_food/presentation/child%20screens/discover.dart';
import 'package:fun_food/presentation/child%20screens/my_servings.dart';
import 'package:fun_food/presentation/child%20screens/quiz.dart';
import 'package:fun_food/presentation/parent%20screens/main_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fun_food/presentation/widgets/showError.dart';
import '../../main.dart';

class ChildMainScreen extends StatefulWidget {
  const ChildMainScreen({Key? key}) : super(key: key);

  @override
  State<ChildMainScreen> createState() => _ChildMainScreenState();
}

class _ChildMainScreenState extends State<ChildMainScreen> {
  TextEditingController pin = TextEditingController();
  @override
  void initState() {
    playLoopedMusic();

    super.initState();
  }
// design the interface in child page
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          if (instance.state != PlayerState.PLAYING) {
            await resumeMusic();
            setState(() {});
          } else {
            await pauseMusic();
            setState(() {});
          }
        },
        child: instance.state != PlayerState.PLAYING
            ? Icon(Icons.volume_up_rounded)
            : Icon(Icons.volume_mute_rounded),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              width: size.width,
              height: size.height,
              child: Image.asset(
                "assets/main_kid.jpg",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Fun Food",
                        style: TextStyle(
                            fontFamily: "food",
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Enter PIN to go to Parent Page"),
                                    content: TextField(
                                      obscureText: true,
                                      controller: pin,
                                      maxLength: 4,
                                      decoration: const InputDecoration(
                                        label: Text("PIN"),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () async {
                                            if (pin.text ==
                                                await Storage.getPIN()) {
                                              pauseMusic();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MainParentScreen()));
                                            } else {
                                              showMessage(
                                                  "The pin is not correct",
                                                  context);
                                            }
                                          },
                                          child: const Text("Confirm")),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.person_pin_circle_outlined,
                            size: 40,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 100,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: size.width,
                  height: size.height * 0.5,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyServings()));
                        },
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                width: size.width * 0.5,
                                height: size.height * 0.35,
                                child: Image.asset(
                                  "assets/my_servings.png",
                                  fit: BoxFit.contain,
                                )),
                            Container(
                              height: size.height * 0.05,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: Center(
                                child: Text(
                                  "My Servings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatBot()));
                        },
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                width: size.width * 0.5,
                                height: size.height * 0.35, //size of image in child page
                                child: Image.asset(
                                  "assets/quiz.png",
                                  fit: BoxFit.contain,
                                )),
                            Container(
                              height: size.height * 0.05,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: Center(
                                child: Text(
                                  "Quiz",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Discover()));
                        },
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                width: size.width * 0.5,
                                height: size.height * 0.35,
                                child: Image.asset(
                                  "assets/discover.png",
                                  fit: BoxFit.contain,
                                )),
                            Container(
                              height: size.height * 0.05,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: Center(
                                child: Text(
                                  "Discover",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyCityScreen()));
                        },
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                width: size.width * 0.5,
                                height: size.height * 0.35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/city.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                )),
                            Container(
                              height: size.height * 0.05,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: Center(
                                child: Text(
                                  "City",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
