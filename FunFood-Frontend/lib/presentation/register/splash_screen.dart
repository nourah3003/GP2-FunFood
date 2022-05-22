import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/classes/storage.dart';
import 'package:fun_food/main.dart';
import 'package:fun_food/presentation/child%20screens/main_screen.dart';
import 'package:fun_food/presentation/parent%20screens/main_screen.dart';
import 'package:fun_food/presentation/register/sign_in.dart';

import '../../classes/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<User?>? fUser;

  Future<User?> processInfo() async {
    Map<String, dynamic>? localData = await Storage.isEmpty();
    if (localData.isEmpty) {
      return null;
    } else {
      if (await Storage.getState() == "1") {
        dynamic rep =
            await API.signIn(localData["email"], localData["password"]);
        if (rep.runtimeType == User) {
          user = rep;
          return rep;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  @override
  void initState() {
    fUser = processInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder(
      future: fUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChildMainScreen()));
            });
            
          } else {
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScren()));
            });
          }
        }
        
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                width: size.width,
                height: size.height,
                child: Image.asset("assets/login.png")),
            Positioned(
              bottom: size.height * 0.1,
              child: SizedBox(
                  width: size.width * 0.8,
                  child: LinearProgressIndicator(
                    color: Colors.green.withOpacity(0.8),
                  )),
            )
          ],
        );
      },
    ));
  }
}
