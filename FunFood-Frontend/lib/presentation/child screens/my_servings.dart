import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/child%20screens/basket.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

import '../../classes/api.dart';

class MyServings extends StatefulWidget {
  const MyServings({Key? key}) : super(key: key);

  @override
  State<MyServings> createState() => _MyServingsState();
}

class _MyServingsState extends State<MyServings> {
  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    if (double.tryParse(str) != null) {
      if (double.tryParse(str)! > 0 && double.tryParse(str)! < 7) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<int>? num;
  Future<List<dynamic>?>? items;
  @override
  void initState() {
    num = API.getNumOfMeals(user!.userID);
    items = API.getAll(user!.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
                child: Icon(Icons.shopping_basket),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Bascket())))
                      .then((value) {
                    num = API.getNumOfMeals(user!.userID);
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
                    color: Colors.red, borderRadius: BorderRadius.circular(15)),
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
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/my servings.jpg"),
            Column(
              children: [
                Container(
                  height: size.height * 0.12,
                  color: Colors.green.withOpacity(0.6),
                  child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                              const Text(
                                "My Servings",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 2)),
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          items = API.getFruits(user!.userID);
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                                maxRadius: 45,
                                child: Image.asset("assets/fruit icon.png")),
                            Text(
                              "Fruits",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          items = API.getVegetables(user!.userID);
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                                maxRadius: 45,
                                child: Image.asset("assets/veg icon.png")),
                            Text("Vegetables",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          items = API.getAll(user!.userID);
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                                maxRadius: 45,
                                child: Image.asset("assets/all icon.png")),
                            Text("All",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: FutureBuilder<List<dynamic>?>(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            padding: EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 4,
                                        spreadRadius: 4,
                                        offset: Offset(1, 3),
                                        color: Colors.grey)
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        url +
                                            "/" +
                                            snapshot.data![index]["image_url"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.07,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              snapshot.data![index]["name"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Text(
                                                              "Are you sure you want to add this serving?"),
                                                          actions: [
                                                            Center(
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await API
                                                                        .addServing(
                                                                      user!
                                                                          .userID,
                                                                      snapshot.data![
                                                                              index]
                                                                          [
                                                                          "name"],
                                                                      url +
                                                                          "/" +
                                                                          snapshot.data![index]
                                                                              [
                                                                              "image_url"],
                                                                    );
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        size.width *
                                                                            0.2,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                    child: Text(
                                                                      "Yes",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )),
                                                            ),
                                                            Center(
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        size.width *
                                                                            0.2,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                    child: Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )),
                                                            )
                                                          ],
                                                        );
                                                      }).whenComplete(() {
                                                   num = API.getNumOfMeals(user!.userID);
                                                    setState(() {});
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 25,
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                    }
                    return Center(
                        child: Container(
                            padding: EdgeInsets.all(18),
                            width: size.width * 0.5,
                            alignment: Alignment.center,
                            height: size.height * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(3, 0),
                                      blurRadius: 4,
                                      spreadRadius: 4,
                                      color: Colors.grey)
                                ]),
                            child: const Text(
                              "No Servings Yet !, Add some servings !",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )));
                  },
                ))
              ],
            ),
          ],
        ));
  }
}
