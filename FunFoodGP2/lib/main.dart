import 'package:flutter/material.dart';
import 'package:food_fun/API/api.dart';

import 'package:food_fun/classes/storage.dart';
import 'package:food_fun/ui/add_item.dart';
import 'package:food_fun/ui/all_screen.dart';
import 'package:food_fun/ui/edit_item.dart';
import 'package:food_fun/ui/edit_station.dart';
import 'package:food_fun/ui/forgot_password.dart';
import 'package:food_fun/ui/fruits.dart';
import 'package:food_fun/ui/login_screen.dart';
import 'package:food_fun/ui/logup_screen.dart';
import 'package:food_fun/ui/notifications.dart';
import 'package:food_fun/ui/parent_dashboard.dart';
import 'package:food_fun/ui/profile.dart';
import 'package:food_fun/ui/vegetables.dart';

import 'classes/user.dart';

Storage storage = Storage();
dynamic loginResponse;
//null ؟ قدتأخذ قيمة
User? user;
void main() async {
  // مهم جدا بدونه لا يصلح التطبيق
  WidgetsFlutterBinding.ensureInitialized();
  // جلب المعلومات من التخزين المحلي
  Map<String, String>? info = await storage.getInfo();
  // التأكد من وجود التخزين
  if (info != null) {
    // التأكد من وجود بيانات
    if (info.isNotEmpty) {
      // API نقوم بتسجيل الدخول عن طريق ال
      loginResponse = await API.login(info["email"]!, info["password"]!);

      if (loginResponse.runtimeType == User) {
        user = loginResponse;
      }
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // يحتاجها كلاس نافيغاتور من اجل التنقل في التطبيق
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          if (user == null) {
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          } else {
            return MaterialPageRoute(
                builder: (context) =>  ParentDashboard());
          }
        } else if (settings.name == "forgotPassword") {
          return MaterialPageRoute(
              builder: (context) => const ForgotPassword());
        } else if (settings.name == "login") {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        } else if (settings.name == "logup") {
          return MaterialPageRoute(builder: (context) => const LogupScreen());
        } else if (settings.name == "servings") {
          return MaterialPageRoute(builder: (context) => const Notifications());
        } else if (settings.name == "addFood") {
          return MaterialPageRoute(builder: (context) => const AddFood());
        } else if (settings.name == "profile") {
          return MaterialPageRoute(builder: (context) => const Profile());
        } else if (settings.name == "editFood") {
          return MaterialPageRoute(builder: (context) => const EditFood());
        } else if (settings.name == "fruits") {
          return MaterialPageRoute(builder: (context) => const FruitsScreen());
        } else if (settings.name == "vegetables") {
          return MaterialPageRoute(builder: (context) => const VegetablesScreen());
        } else if (settings.name == "all") {
          return MaterialPageRoute(builder: (context) => const AllScreen());
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}
