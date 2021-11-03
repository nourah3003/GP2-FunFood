
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp3funfood/login.dart';

class resetPassword extends StatelessWidget {
TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Forget Password Page", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 19 ,color: Colors.blueGrey,height: 4),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  labelText: "Enter your Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
            });
          }, child: Text("Reset Password"))
        ],
      ),
    );
  }
}
