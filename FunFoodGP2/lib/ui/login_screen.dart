import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';

import '../classes/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: size.height * 0.4,
                      width: size.width,
                      child: SvgPicture.asset(
                        "assets/upperBackground.svg",
                        fit: BoxFit.fill,
                      )),
                  SizedBox(
                      height: size.height * 0.4,
                      width: size.width,
                      child: SvgPicture.asset(
                        "assets/bottomBackground.svg",
                        fit: BoxFit.fill,
                      ))
                ],
              ),
              Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.1,
                  child: const Text(
                    "FUN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
              Positioned(
                  right: size.width * 0.1,
                  bottom: size.height * 0.1,
                  child: const Text(
                    "FOOD",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.7,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(60),
                                    bottomRight: Radius.circular(60))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                        label: Text("Email")),
                                  ),
                                  TextField(
                                    controller: password,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        label: Text("Password")),
                                  )
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "forgotPassword");
                              },
                              child: const Text("Forgot password ?")),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "logup");
                              },
                              child: const Text("Don't have an account?"))
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.42,
                      left: size.width * 0.6,
                      child: TextButton(
                          onPressed: () async {
                            if (email.text.isNotEmpty &&
                                password.text.isNotEmpty) {
                              loginResponse =
                                  await API.login(email.text, password.text);
                              if (loginResponse.runtimeType == User) {
                                user = loginResponse;
                                Navigator.pushReplacementNamed(context, "/");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(loginResponse)));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "please fill all fields and try again")));
                            }
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.cyanAccent,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
