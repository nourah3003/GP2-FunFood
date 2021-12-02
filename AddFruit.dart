import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gp3funfood/UplodImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class  AddFruit extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AddFruit> {
  TextEditingController name = TextEditingController();
  TextEditingController benfit = TextEditingController();
  final firbase = FirebaseFirestore.instance;
  
  alertDialog( BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done'),
            content: Text('The vegetable was successfully added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
  
  create()async{
    try{
    await firbase.collection("Fruits").add({
      "name":name.text,
      "benefit":benfit.text
    });
    }catch(e){
      print(e);
    }
  }
  error(context , e){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Error message"),
        content: Text(e.toString()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 95,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(35),
                    bottomLeft: Radius.circular(35)),
                color: Colors.transparent.withOpacity(0.10),
              ),
              child: Center(
                child: Text("Add Page",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: "Name:",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomLeft,

              child: Text("Picture:", style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold, color: Colors.indigoAccent),
              ),
            ),
            RaisedButton(
              child: Text('Upload Picture'),
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UplodImage()));
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: benfit,
              decoration: InputDecoration(
                  labelText: "Benefit:",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomLeft,

              child: Text("Sound:", style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold, color: Colors.indigoAccent),
              ),
            ),
            RaisedButton(
              child: Text('Upload file'),
              color: Colors.lightBlue,
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> UplodImage()));
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: (){
                      if(name.text.isEmpty || benfit.text.isEmpty){
                        error(context,"Please fill the required field");
                      }
                      else {
                        create();
                        name.clear();
                        benfit.clear();
                        alertDialog(
                            context,
                       );
                      }
                    },
                    child: Text("Add")),
              ],
            )
          ],
        ),
      ),
    );
  }

}
