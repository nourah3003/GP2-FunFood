import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: SvgPicture.asset(
                "assets/top notify.svg",
                fit: BoxFit.fill,
              )),
          Positioned(
              top: size.height * 0.1,
              left: size.width * 0.05,
              child: const Text(
                "Servings",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )),
          Positioned(child: Center(
            child: FutureBuilder<List<Map<String, dynamic>>?>(
                future: API.servings(user!.id),
                builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    width: size.width * 0.8,
                    height: size.height * 0.6,
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ], borderRadius: BorderRadius.circular(4)),
                            width: size.width * 0.6,
                            height: size.height * 0.2,
                            child: Row(children: [
                              SizedBox(
                                width: size.width * 0.3,
                                height: size.height * 0.2,
                                child: Image.network(
                                  snapshot.data![index]["image"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                snapshot.data![index]["name"],
                                style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )))
                            ]),
                          );
                        }),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/awk.svg",fit: BoxFit.fill,),
                  Text("No data to date !")
                ],
              );
            }),
          ))
        ],
      ),
    );
  }
}
