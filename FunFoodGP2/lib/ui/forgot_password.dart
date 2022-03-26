import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';

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
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                width: size.width,
                height: size.height * 0.7,
                child: SvgPicture.asset(
                  "assets/sad.svg",
                  fit: BoxFit.fill,
                )),
            Center(
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        width: size.width * 0.8,
                        height: size.height * 0.5,
                        child: const Text(""),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: size.height,
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [Colors.red, Colors.amberAccent])),
                            child: const Text(
                              "Don't panic ! Send us your email address to log back in !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextField(
                                  controller: email,
                                  decoration:
                                      InputDecoration(label: Text("Email")),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      if (email.text.isNotEmpty) {
                                        String response = await API
                                            .forgotPassword(email.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                  response)));
                                      }else {
                                         ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                  "please fill all fields")));
                                      }
                                    },
                                    child: Text("Send me email"))
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
