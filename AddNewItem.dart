
import 'package:flutter/material.dart';
import 'dart:io';

  void main() {

    class AddNewItem extends StatefulWidget {



    List<String>fruits = ["Apple","Banana","Orange","Watermelon","Strawberry","Mango","Fig","Pineapple","Grapes"];
List<String>vegetables = ["Lettuce","Lemon","Tomatoes","Carrots","Cucumber","Potatoes","Onions","Eggplant"];
//add name

    print("Name: ");
    String nameOfItem = stdin.readLineSync();
    if (nameOfItem==fruits[]||vegetables[]){
    print("The item already available");
    //fruits=Add.fruits[nameOfItem];
    //vegetables=Add.vegetables[nameOfItem];

    }else{
    print(nameOfItem);}


    //add picture
    print("Picture: ");
    SizedBox(height: 40),
    SizedBox(
    width: 280,
    height: 150,
    child: RaisedButton(
    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
    onPressed: (){},
    color: Colors.blueGrey,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30))
    ),
    child: Text("Upload Picture" ,
    style: TextStyle(color: Colors.white70 ,fontSize: 25,fontStyle:FontStyle.italic),),
    ),
    ),



    //add Benefit

    print("Benefit: ");
        String Benefit = stdin.readLineSync();
            print(Benefit);




    //add sound

    print("Sound: ");
    SizedBox(height: 40),
            SizedBox(
              width: 280,
              height: 150,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                onPressed: (){},
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("Upload file" ,
                  style: TextStyle(color: Colors.white70 ,fontSize: 25,fontStyle:FontStyle.italic),),
              ),
            ),

    SizedBox(height: 40),
    SizedBox(
    width: 220,
    height: 150,
    child: RaisedButton(
    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
    onPressed: (){},
    color: Colors.blueGrey,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30))
    ),
    child: Text("Add" ,
    style: TextStyle(color: Colors.white70 ,fontSize: 25,fontStyle:FontStyle.italic),),
    ),
    ),


  }
}



