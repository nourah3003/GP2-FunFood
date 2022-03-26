import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditFood extends StatefulWidget {
  const EditFood({Key? key}) : super(key: key);

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: SvgPicture.asset(
                  "assets/sign up top.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.3,
                child: SvgPicture.asset(
                  "assets/sign up bottom.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: size.height * 0.1,
            left: size.width * 0.05,
            child: const Text("Delete and Edit food item!",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24))),
        Positioned(
            
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.6,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Image.network(snapshot.data![index]["url"]),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(snapshot.data![index]["name"]),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                ),
                              )
                            ],
                          );
                        });
                  }
                } else if(snapshot.connectionState == ConnectionState.active) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/no data.svg"),
                    const Text("No food items added yet !"),
                  ],
                );
              }),
            ))
      ]),
    );
  }
}
