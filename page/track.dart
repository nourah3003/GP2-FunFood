import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:gp3funfood/page/images_page.dart';
import 'package:gp3funfood/page/selectable_item_widget.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:flutter/material.dart';

class track extends StatefulWidget {
  const track({Key? key}) : super(key: key);

  @override
  _trackState createState() => _trackState();
}

class _trackState extends State<track> {

  final firbase = FirebaseFirestore.instance;

  delete() async {
    try {
      await firbase.collection("users").doc("Fruits").delete();
    } catch (e) {
      print(e);
    }
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

          ),
        ),
        Column(
            children: [
            SingleChildScrollView(
            physics: ScrollPhysics(),
        child: StreamBuilder<QuerySnapshot>(
          stream: firbase.collection("users").snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,i){
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    return Text(x['name'] ,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.indigo),);
                  });
            } else{
              return Center(child: CircularProgressIndicator());
            }
          },
        )),
          ],
        ),


              ],
          ),
        ),
    );
  }

}