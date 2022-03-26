import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../API/api.dart';
import '../classes/user.dart';
import '../main.dart';

class LogupScreen extends StatefulWidget {
  const LogupScreen({Key? key}) : super(key: key);

  @override
  State<LogupScreen> createState() => _LogupScreenState();
}

class _LogupScreenState extends State<LogupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                child: const Text("FUN FOOD",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24))),
            Positioned(
                top: size.height * 0.2,
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.7,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: email,
                        decoration: InputDecoration(label: Text("Email")),
                      ),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(label: Text("Password")),
                      ),
                      TextField(
                        controller: fullName,
                        decoration: InputDecoration(label: Text("Full Name")),
                      ),
                      TextField(
                        controller: phone,
                        decoration: InputDecoration(label: Text("Phone")),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: size.height * 0.5,
                left: size.width * 0.65,
                child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 6, 199, 199),
                    child: IconButton(
                      onPressed: () async{
                         if (email.text.isNotEmpty &&
                                password.text.isNotEmpty && fullName.text.isNotEmpty&& phone.text.isNotEmpty) {
                              loginResponse =
                                  await API.logup(email.text, password.text,fullName.text, phone.text);
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
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ))),
            Positioned(
                bottom: 0,
                left: size.width * 0.16,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  child: const Text(
                    "Already have an account ? log in",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
