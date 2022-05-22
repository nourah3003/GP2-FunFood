import 'package:flutter/material.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/classes/user.dart';
import 'package:fun_food/presentation/register/forgot_password.dart';
import 'package:fun_food/presentation/register/sign_up.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

import '../../main.dart';
import '../parent screens/main_screen.dart';

class SignInScren extends StatefulWidget {
  const SignInScren({Key? key}) : super(key: key);

  @override
  State<SignInScren> createState() => _SignInScrenState();
}

class _SignInScrenState extends State<SignInScren> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
                width: size.width,
                height: size.height,
                child: Image.asset("assets/login.png")),
            Column(
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
                            width: size.width,
                            color: Colors.green.withOpacity(0.6),
                            height: size.height,
                            child: const Padding(
                              padding: EdgeInsets.all(18),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            Color.fromARGB(255, 80, 240, 85).withOpacity(0.8)),
                    child: TextField(
                      controller: email,
                      maxLines: 1,
                      style: TextStyle(fontSize: 23, color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Text(
                            "Email",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            Color.fromARGB(255, 80, 240, 85).withOpacity(0.8)),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      style: TextStyle(fontSize: 23, color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Text(
                            "Password",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: size.width * 0.5,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green.withOpacity(0.8)),
                      child: TextButton(
                        onPressed: () async {
                          if (email.text.isNotEmpty &&
                              password.text.isNotEmpty) {
                            dynamic rep =
                                await API.signIn(email.text, password.text);
                            if (rep.runtimeType == User) {
                              user = rep;
                             
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainParentScreen()));
                            } else {
                              showMessage(rep, context);
                            }
                          } else {
                            showMessage("please fill all required fields",
                                      context);
                          }
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    "Don't have an account ? Sign up",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text(
                    "Forgot password ?",
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
