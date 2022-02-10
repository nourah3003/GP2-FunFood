import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gp3funfood/Childpage.dart';
import 'package:gp3funfood/ChoseEdit.dart';
import 'package:gp3funfood/ParentPage.dart';
import 'package:image_picker/image_picker.dart';

class ViewFruit extends StatefulWidget {

  @override
  _ViewFruitVState createState() => _ViewFruitVState();
}

class _ViewFruitVState extends State<ViewFruit> {

  TextEditingController nameController = TextEditingController();
  TextEditingController benefitController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  final firbase = FirebaseFirestore.instance;
  String imageUrl ="";

  Future<void> getImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    image = (await _picker.getImage(source: ImageSource.gallery))!;
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _storage.ref()
          .child('Images/image')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Path Received');
    }
  }

  _buildTextField(TextEditingController controller, String labelText){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white54,border: Border.all(color: Colors.black26)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.blueGrey),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back , size: 30 ,color: Colors.blueGrey,),
          onPressed: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=> ChoseEdit()));
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.home, size: 30 ,color: Colors.blueGrey,),
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Childpage()));

            },
          ),
        ],

        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50)),
            color: Colors.transparent.withOpacity(0.20),
          ),

        ),

        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Text('Learn about Vegetables & Fruits',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic
          ),
        ),
        centerTitle: true,
      ),


      body: StreamBuilder<QuerySnapshot>(

        stream: firbase.collection("Fruits").snapshots(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,i){

                  QueryDocumentSnapshot doc = snapshot.data!.docs[i];



                  return ListTile(

                    leading: IconButton(
                      icon: Icon(Icons.read_more),
                      color: Colors.black38,
                      onPressed: (){
                        nameController.text = doc['name'];
                        benefitController.text = doc['benefit'];
                        imageUrlController.text = doc['image'];

                        showDialog(context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                color: Colors.white12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          doc['name'],
                                          style: TextStyle(color: Colors.brown, fontSize: 20,fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(children: <Widget>[
                                          Text(
                                            doc['benefit'],
                                            style: TextStyle(color: Colors.black38),
                                          ),
                                          //  Text(
                                          //   doc['image'],
                                          //    style: TextStyle(color: Colors.black38),
                                          // ),

                                        ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                        trailing: Image.network(
                                          doc['image'],
                                          //  height: 30,
                                          //  fit: BoxFit.cover,
                                          // width: 30,
                                         fit: BoxFit.fill,

                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),

                    title: Text(
                      doc['name'],
                      style: TextStyle(color: Colors.brown, fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    //subtitle: Column(children: <Widget>[
                      // Text(
                      //   doc['benefit'],
                      //   style: TextStyle(color: Colors.black38),
                      // ),
                    //
                    // ],
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    // ),
                    // trailing: Image.network(
                    //   doc['image'],
                    //   //  height: 3,
                    //   //  fit: BoxFit.cover,
                    //   // width: 3,
                    //   fit: BoxFit.fill,
                    //
                    // ),
                  );
                }
            );
          } else
            return Text('NO data');
        },
      ),
    );
  }
  // fetchData(){
  //   CollectionReference collectionReference = FirebaseFirestore.instance.collection('Vegetables') ;
  //   collectionReference.snapshots().listen((snapshot) {
  //
  //     List documents;
  //     setState(() {
  //       documents =  snapshot.docs;
  //     });
  //   });
  // }
}