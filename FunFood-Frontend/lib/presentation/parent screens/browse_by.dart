import 'package:flutter/material.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/parent%20screens/add.dart';
import 'package:fun_food/presentation/parent%20screens/edit.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

String? browseBy;

class BrowseBy extends StatefulWidget {
  const BrowseBy({Key? key}) : super(key: key);

  @override
  State<BrowseBy> createState() => _BrowseByState();
}

class _BrowseByState extends State<BrowseBy> {
  Future<dynamic>? items;
  @override
  void initState() {
    if (browseBy == "all") {
      items = API.getAll(user!.userID);
    } else if (browseBy == "fruits") {
      items = API.getFruits(user!.userID);
    } else {
      items = API.getVegetables(user!.userID);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                              browseBy!,
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
          SizedBox(
            height: size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  browseBy!.toUpperCase() + " LIST",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                browseBy != "all"
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddScreen()))
                              .then((value) {
                            if (browseBy == "all") {
                              items = API.getAll(user!.userID);
                            } else if (browseBy == "fruits") {
                              items = API.getFruits(user!.userID);
                            } else {
                              items = API.getVegetables(user!.userID);
                            }
                            setState(() {});
                          });
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 30,
                        ))
                    : Container()
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<dynamic>(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                width: size.width * 0.8,
                                height: size.height * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.withOpacity(0.6)),
                                child: Row(
                                  children: [
                                    Image.network(url +
                                        "/" +
                                        snapshot.data![index]["image_url"]),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text(
                                              snapshot.data![index]["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 23),
                                            ))),
                                        browseBy != "all"
                                            ? Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            if (isFruit!) {
                                                              itemID = snapshot
                                                                          .data![
                                                                      index]
                                                                  ["fruit_id"];
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const EditingScreen()));
                                                            } else {
                                                              itemID = snapshot
                                                                          .data![
                                                                      index][
                                                                  "vegetable_id"];
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const EditingScreen())).then(
                                                                  (value) {
                                                                if (browseBy ==
                                                                    "all") {
                                                                  items = API
                                                                      .getAll(user!
                                                                          .userID);
                                                                } else if (browseBy ==
                                                                    "fruits") {
                                                                  items = API
                                                                      .getFruits(
                                                                          user!
                                                                              .userID);
                                                                } else {
                                                                  items = API
                                                                      .getVegetables(
                                                                          user!
                                                                              .userID);
                                                                }
                                                                setState(() {});
                                                              });
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.edit_sharp,
                                                            color:
                                                                Colors.purple,
                                                          )),
                                                      IconButton(
                                                          onPressed: () async {
                                                            String rep;
                                                            if (isFruit!) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          "Are you sure you want to delete this item?"),
                                                                      actions: [
                                                                        Center(
                                                                          child: TextButton(
                                                                              onPressed: () async {
                                                                                itemID = snapshot.data![index]["fruit_id"];
                                                                                rep = await API.deleteFruit(user!.userID, itemID!);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height * 0.05,
                                                                                width: MediaQuery.of(context).size.width * 0.4,
                                                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Yes",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.of(context).size.height * 0.05,
                                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "No",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  }).then((value) {
                                                                if (browseBy ==
                                                                    "all") {
                                                                  items = API
                                                                      .getAll(user!
                                                                          .userID);
                                                                } else if (browseBy ==
                                                                    "fruits") {
                                                                  items = API
                                                                      .getFruits(
                                                                          user!
                                                                              .userID);
                                                                } else {
                                                                  items = API
                                                                      .getVegetables(
                                                                          user!
                                                                              .userID);
                                                                }
                                                                setState(() {});
                                                              });
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          "Are you sure you want to delete this item?"),
                                                                      actions: [
                                                                        Center(
                                                                          child:
                                                                              TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              itemID = snapshot.data![index]["vegetable_id"];
                                                                              rep = await API.deleteVegetable(user!.userID, itemID!);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.of(context).size.height * 0.05,
                                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Yes",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.of(context).size.height * 0.05,
                                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "No",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  }).then((value) {
                                                                if (browseBy ==
                                                                    "all") {
                                                                  items = API
                                                                      .getAll(user!
                                                                          .userID);
                                                                } else if (browseBy ==
                                                                    "fruits") {
                                                                  items = API
                                                                      .getFruits(
                                                                          user!
                                                                              .userID);
                                                                } else {
                                                                  items = API
                                                                      .getVegetables(
                                                                          user!
                                                                              .userID);
                                                                }
                                                                setState(() {});
                                                              });
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                ))
                                            : Container(),
                                      ],
                                    ))
                                  ],
                                ),
                              );
                            });
                      }
                    }
                    return Center(
                      child: Text(
                          "Nothing to browse !, go ahead and click the add button"),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
