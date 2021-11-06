import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp3funfood/ParentPage.dart';
import 'package:gp3funfood/SignupPage.dart';
import 'package:gp3funfood/firebases.dart';
import 'package:gp3funfood/resetPassword.dart';

class login extends StatelessWidget {
  firebases fireb = firebases();
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(45),
                    bottomLeft: Radius.circular(45)),
                color: Colors.grey.withOpacity(0.10),
                gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.lime,
                    ]
                ),
              ),
              child: Center(
                child: Text("Login" ,
                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30 ,color: Colors.indigo),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: EmailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                    labelText: "Enter Email..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: PasswordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                    labelText: "Enter Password..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>resetPassword()));
                },
                child: Text("Forget Password.."),

              ),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 90),
                  backgroundColor: Colors.indigoAccent[400],
                ),


                onPressed: (){
                  if(EmailController.text.isNotEmpty && PasswordController.text.isNotEmpty) {
                    fireb.loginUser(EmailController.text,PasswordController.text,context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Parentpage()));
                  }else{
                    fireb.error(context, "Please fill the required field");

                  }
                  
                }, 
              child: Text("Login")),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
            },
                child: Text("Don't have an account?"))
          ],
        ),
      ),
    );
  }
}




