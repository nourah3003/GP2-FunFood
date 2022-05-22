import 'package:flutter/material.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

import '../../classes/api.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
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
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back)),
                                const Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Center(
                                    child: Text(
                                      "Forgot Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  ),
                                ),
                              ],
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
                      width: size.width * 0.5,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green.withOpacity(0.8)),
                      child: TextButton(
                        onPressed: () async {
                          if (email.text.isNotEmpty) {
                            dynamic rep = await API.forgotPaassword(email.text);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(rep)));
                          } else {
                            showMessage(
                                "Please fill all required fields", context);
                          }
                        },
                        child: Text(
                          "Recieve Password",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
