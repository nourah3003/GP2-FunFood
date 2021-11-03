import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp3funfood/SignupPage.dart';
import 'package:gp3funfood/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Container(
         width: double.infinity,
         height: MediaQuery.of(context).size.height,
         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Column(
               children: const <Widget>[  //i add the const
                 Text(
                   "Welcome",
                    style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 50,
                      color: Colors.black45
                   ),
                 ),
                 SizedBox(
                   height: 40,
                 ),
               ],
             ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration:  BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/funfood.png")
                )
              ),
            ),
             Column(
               children: <Widget>[
                 // the login button
                 MaterialButton(
                   minWidth: double.infinity,
                   height: 60,
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => login()));

                   },
                 color: Colors.blueAccent,
                 // defining the shape
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(50)
                   ),
                   child: Text(
                     "Log in",
                     style: TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 18
                         ,color: Colors.white
                     ),
                   ),
                 ),
                 // creating the singup button
                 SizedBox(height:20),
                 MaterialButton(
                   minWidth: double.infinity,
                   height:60,
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

                   },
                   color: Colors.redAccent,
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(50)
                   ),
                   child: Text("Sign up",style: TextStyle(

                     fontWeight: FontWeight.w600,fontSize: 18,

                   ),),
                 ),

               ],
             )


           ],
         ),

     ),
     ),
   );
  }
}

