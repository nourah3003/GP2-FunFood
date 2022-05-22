import 'package:flutter/material.dart';

import '../../classes/api.dart';
import '../../main.dart';

class Bascket extends StatefulWidget {
  const Bascket({Key? key}) : super(key: key);

  @override
  State<Bascket> createState() => _BascketState();
}

class _BascketState extends State<Bascket> {
  Future<List<dynamic>?>? items;
  @override
  void initState() {
    items = API.getMealsByDay(user!.userID, DateTime.now().month.toString(),
        DateTime.now().day.toString(), DateTime.now().year.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            // interface of add serving by child
              width: size.width,
              height: size.height,
              child: Image.asset(
                "assets/bascket.jpg",
                fit: BoxFit.cover,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.green.withOpacity(0.6),
                height: size.height * 0.2,
                child: SafeArea(
                    child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        )),
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                   const Text(
                      "My Servings",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              const Text(
                "  I ate today...",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: FutureBuilder<List<dynamic>?>(
                future: items,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          padding: const EdgeInsets.all(8),
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
                                boxShadow: const [
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
                                      snapshot.data![index]["image_url"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: snapshot.data![index]
                                                  ["confirmed"].toString() ==
                                              "1"
                                          ? Colors.green.withOpacity(0.8) // the servings color after confirm
                                          : Colors.red.withOpacity(0.8), //the servings color before confirm
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot.data![index]["name"],
                                            textAlign: TextAlign.center,
                                            style:const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
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
                          padding: const EdgeInsets.all(18),
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
      ),
    );
  }
}
