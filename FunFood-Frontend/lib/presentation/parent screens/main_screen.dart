import 'package:flutter/material.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/classes/storage.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/child%20screens/main_screen.dart';
import 'package:fun_food/presentation/parent%20screens/browse_by.dart';
import 'package:fun_food/presentation/parent%20screens/edit.dart';
import 'package:fun_food/presentation/parent%20screens/notifications.dart';
import 'package:fun_food/presentation/parent%20screens/track.dart';
import 'package:fun_food/presentation/register/sign_in.dart';

class MainParentScreen extends StatefulWidget {
  const MainParentScreen({Key? key}) : super(key: key);

  @override
  State<MainParentScreen> createState() => _MainParentScreenState();
}

DateTime? selectedDate;

class _MainParentScreenState extends State<MainParentScreen> {
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<String>? num;

  @override
  void initState() {
    num = API.getNumOfUnaprovedMeals(user!.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
                child: Icon(Icons.notification_add),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Notifications())))
                      .then((value) {
                    num = API.getNumOfUnaprovedMeals(user!.userID);
                    setState(() {});
                  });
                }),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: FutureBuilder(
                    future: num,
                    builder: (context, snapashot) {
                      if (snapashot.connectionState == ConnectionState.done) {
                        if (snapashot.hasData) {
                          return Text(snapashot.data.toString(),
                              style: TextStyle(fontSize: 23));
                        }
                      }
                      return Text(
                        "0",
                        style: TextStyle(fontSize: 23),
                      );
                    }),
              ),
            )
          ],
        ),
        body: Column(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    resumeMusic();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChildMainScreen()));
                                  },
                                  icon: const Icon(
                                    Icons.child_care_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                              const Text(
                                "Fun Food",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await Storage.setState("0");
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInScren()),
                                            (Route<dynamic> route) => false
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.logout_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Categories",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            height: size.height * 0.41,
                            child: GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.35,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 5),
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    browseBy = "vegetables";
                                    isFruit = false;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BrowseBy()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(3, 0),
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              color: Colors.grey)
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/vegetables.jpg",
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          width: size.width * 0.3,
                                          height: size.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Vegetables",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    browseBy = "fruits";
                                    isFruit = true;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BrowseBy()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(3, 0),
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              color: Colors.grey)
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/fruits.jpg",
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          width: size.width * 0.3,
                                          height: size.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Fruits",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    isFruit = null;
                                    browseBy = "all";
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BrowseBy()));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(3, 0),
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              color: Colors.grey)
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/all.png",
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          width: size.width * 0.3,
                                          height: size.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "All",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Track",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            height: size.height * 0.25,
                            child: GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.2,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 5),
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await selectDate(context);
                                    if (selectedDate != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Tracking()));
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(3, 0),
                                              blurRadius: 2,
                                              spreadRadius: 2,
                                              color: Colors.grey)
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                            width: size.width,
                                            height: size.height,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  "assets/calendar.webp",
                                                  width: size.width,
                                                  height: size.height,
                                                  fit: BoxFit.fill,
                                                ))),
                                        Container(
                                          width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Text(
                                            "Track Your Child Servings",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
