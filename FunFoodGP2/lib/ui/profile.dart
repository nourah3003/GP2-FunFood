import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_fun/main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
                    fit: BoxFit.cover,
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
            left: 0,
            right: 0,
            top:0,
            bottom: 0,
            child: Center(
              child: Container(
                height: size.height*0.7,
                width: size.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Name"),
                      subtitle:
                          Text(user != null ? user!.name : "not speified"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Email"),
                      subtitle:
                          Text(user != null ? user!.email : "not speified"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.password_rounded),
                      title: const Text("ID"),
                      subtitle: Text(
                          user != null ? user!.id.toString() : "not speified"),
                    ),
                    Container(
                      width: size.width * 0.5,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            
                            IconButton(
                              tooltip: "Add new food",
                                onPressed: () {
                                  Navigator.pushNamed(context, "addFood");
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )),
                                 IconButton(
                              tooltip: "Edit and Delete food",
                                onPressed: () {
                                  Navigator.pushNamed(context, "editFood");
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ))
                          ]),
                    ),
                    TextButton(
                        onPressed: () async {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              size: 23,
                            ),
                            Text("Log Out"),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
