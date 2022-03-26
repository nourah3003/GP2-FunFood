import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditingStation extends StatefulWidget {
  String itemID;
  EditingStation({Key? key, required this.itemID}) : super(key: key);

  @override
  State<EditingStation> createState() =>_EditingStationState(itemID: this.itemID);
}

class _EditingStationState extends State<EditingStation> {
  String itemID;
  _EditingStationState({required this.itemID});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              tooltip: "Delete Item",
              onPressed: () {},
              icon: Icon(
                Icons.delete,
              )),
          IconButton(
              tooltip: "Submit changes Item",
              onPressed: () {},
              icon: Icon(Icons.approval))
        ],
      )),
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: SizedBox(
              height: size.height * 0.1,
              child: SvgPicture.asset(
                "assets/lab.svg",
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: size.height * 0.7,
                child: FutureBuilder<Map<String, dynamic>>(
                    builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.4,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Card(
                                  child: Image.network(
                                    snapshot.data!["url"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: size.width,
                                  height: size.height * 0.05,
                                  color: Colors.grey.withOpacity(0.4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: snapshot.data!["name"]),
                                        ),
                                      ),
                                      const Icon(Icons.edit),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.camera,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width,
                            child: TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                  label: Row(
                                    children: [
                                      Text("Info about the food : "),
                                      Icon(Icons.edit),
                                    ],
                                  ),
                                  border: InputBorder.none,
                                  hintText: "apple"),
                            ),
                          ),
                        ],
                      );
                    }
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/no data.svg"),
                      const Text("No food items added yet !"),
                    ],
                  );
                })),
          )
        ],
      ),
    );
  }
}
