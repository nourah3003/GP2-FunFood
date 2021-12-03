import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gp3funfood/ChoseEdit.dart';
import 'package:gp3funfood/ParentPage.dart';

class EditVegetables extends StatefulWidget {

  @override
  _EditFruitsState createState() => _EditFruitsState();
}

class _EditFruitsState extends State<EditVegetables> {

  TextEditingController nameController = TextEditingController();
  TextEditingController benefitController = TextEditingController();
  // TextEditingController imageUrlController = TextEditingController();

  final firbase = FirebaseFirestore.instance;




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

//CollectionReference ref = FirebaseFirestore.instance.collection('Fruits');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back , size: 30 ,color: Colors.blueGrey,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChoseEdit()));
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.home, size: 30 ,color: Colors.blueGrey,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Parentpage()));

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
        title: Text('Edit Vegetables',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic
          ),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: firbase.collection("Vegetables").snapshots(),
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
                      icon: Icon(Icons.edit),
                      color: Colors.black38,
                      onPressed: (){
                        nameController.text = doc['name'];
                        benefitController.text = doc['benefit'];
                        //  imageUrlController.text = doc['ImageUrl'];



                        showDialog(context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                color: Colors.white12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      _buildTextField(nameController, 'Name:'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _buildTextField(benefitController, 'benefit:'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      //  _buildTextField(imageUrlController, 'ImageUrl:'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      FlatButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text('Edit'),
                                        ),
                                        color: Colors.green,
                                        onPressed: (){
                                          snapshot.data!.docs[i]
                                              .reference.update({
                                            "name": nameController.text,
                                            "benefit": benefitController.text,
                                            //  "ImageUrl": imageUrlController.text,
                                          }).whenComplete(() => Navigator.pop(context));

                                        },
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
                    subtitle: Column(children: <Widget>[
                      Text(
                        doc['benefit'],
                        style: TextStyle(color: Colors.black38),
                      ),
                      // Text(
                      // doc['name'],
                      //   style: TextStyle(color: Colors.white),
                      // ),

                    ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    // trailing: Image.network(
                    // doc['imageUrl'],
                    //  height: 100,
                    //  fit: BoxFit.cover,
                    // width: 100,
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
}