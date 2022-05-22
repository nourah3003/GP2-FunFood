import 'package:flutter/material.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/parent%20screens/main_screen.dart';
import 'package:fun_food/presentation/register/email_validator.dart';
import 'package:fun_food/presentation/register/sign_in.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

import '../../classes/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pin = TextEditingController();
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
                                  "Sign Up",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 80, 240, 85)
                                  .withOpacity(0.8)),
                          child: Form(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              validator: isValid,
                              controller: email,
                              maxLines: 1,
                              style:const TextStyle(fontSize: 23, color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 80, 240, 85)
                                  .withOpacity(0.8)),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              controller: password,
                              obscureText: true,
                              validator: (val) {
                                if (val != null) {
                                  if (val.length < 8) {
                                    return "Password's too short";
                                  }
                                }
                              },
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text(
                                    "Password",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 80, 240, 85)
                                  .withOpacity(0.8)),
                          child: TextField(
                            controller: name,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: Text(
                                  "Full Name",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
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
                              color: Color.fromARGB(255, 80, 240, 85)
                                  .withOpacity(0.8)),
                          child: TextField(
                            controller: pin,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: Text(
                                  "PIN",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
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
                                    password.text.isNotEmpty &&
                                    name.text.isNotEmpty &&
                                    pin.text.isNotEmpty) {
                                  if (password.text.length >= 8) {
                                    dynamic rep = await API.signUp(email.text,
                                        password.text, name.text, pin.text);
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
                                    showMessage(
                                        "Password's too short, please enter at least 8 characters",
                                        context);
                                  }
                                } else {
                                  showMessage("please fill all required fields",
                                      context);
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScren()));
                        },
                        child: Text(
                          "Already Have an Account ? Sign in",
                          style: TextStyle(color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
