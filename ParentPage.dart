import 'package:flutter/material.dart';
import 'package:gp3funfood/ChoseAdd.dart';
import 'package:gp3funfood/ChoseDelete.dart';

class Parentpage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          color: Colors.transparent.withOpacity(0.10),
        ),
        child: Center(
          child: Text("Parent page" ,
            style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30 ,color: Colors.blueGrey,fontStyle:FontStyle.italic),
          ),
        ),
      ),
              SizedBox(height: 30),
              SizedBox(
                 width: 370,
                 height: 100,
                 child: RaisedButton(
                   padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ChoseAdd()));
                   },
                   color: Colors.deepPurple,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(30))
                   ),
                   child: Text("Add new fruits or vegetables" ,
                   style: TextStyle(color: Colors.lime ,fontSize: 23,fontStyle:FontStyle.italic),),
                 ),
               ),
              SizedBox(height: 40),
              SizedBox(
                      width: 370,
                      height: 100,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChoseDelete()));

                        },
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text("Delete fruit or vegetable" ,
                          style: TextStyle(color: Colors.lime ,fontSize: 25,fontStyle:FontStyle.italic),),
                      ),
                    ),
              SizedBox(height: 40),
              SizedBox(
                      width: 370,
                      height: 100,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),

                        onPressed: (){},

                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text("Edit fruits or vegetables" ,
                          style: TextStyle(color: Colors.lime ,fontSize: 25,fontStyle:FontStyle.italic),),
                      ),
                    ),
              SizedBox(height: 40),
              SizedBox(
                width: 370,
                height: 100,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),

                  onPressed: (){},

                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text("Track of servings" ,
                    style: TextStyle(color: Colors.lime ,fontSize: 25,fontStyle:FontStyle.italic),),
                ),
              ),
],
    ),
    ),
    );

  }
}
