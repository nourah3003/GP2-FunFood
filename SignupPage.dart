import 'package:flutter/material.dart';
import 'package:gp3funfood/firebases.dart';
import 'package:gp3funfood/login.dart';

class SignupPage extends StatelessWidget {
 firebases fireb = firebases();
  TextEditingController EmailController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              child: Center(
                child: Text("Sign up" ,
                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30, color: Colors.indigo),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: EmailController,
                decoration: InputDecoration(
                    labelText: "Enter Email..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: UsernameController,
                decoration: InputDecoration(
                    labelText: "Enter Username..",
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
                    labelText: "Enter Password..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))
                ),
              ),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 90),
                  backgroundColor: Colors.indigoAccent[400],
                ),
                onPressed: (){
                  if(EmailController.text.isNotEmpty && PasswordController.text.isNotEmpty && UsernameController.text.isNotEmpty){
                   fireb.createUser(EmailController.text, UsernameController.text, PasswordController.text, context);
                  }else if(PasswordController.text.length < 8){
                    fireb.error(context, "The Password must be at least 8 charcters");
                  }
                  else{
                    fireb.error(context, "Please fill the required field");
                  }
                },
                child: Text("Sign up")),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                }, child: Text("Already have an account?"))
          ],
        ),
      ),
    );
  }
}


