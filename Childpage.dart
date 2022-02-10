import 'package:flutter/material.dart';
import 'package:drag_select_gridview_example/page/select_grid_page.dart';



class Childpage extends StatelessWidget {
  final
  urlImages = [
  'https://t3.ftcdn.net/jpg/02/69/44/84/240_F_269448426_QfLGK3YahmfejKntN7EqAdiARKyeAIHQ.jpg',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(    margin: EdgeInsets.only(bottom: 20),
              height: 300,
              width: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/funfood.png'),
        fit: BoxFit.cover,
      ),
    ),



              child: Center(
                child: Text("child page" ,
                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30 ,color: Colors.black,fontStyle:FontStyle.normal),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 80,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFruit()));

                },

                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("Learn about fruits/vegetables" ,
                  style: TextStyle(color: Colors.black ,fontSize: 23,fontStyle:FontStyle.italic),),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 80,
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectGridPage()));
    },

                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("Add Servings" ,
                  style: TextStyle(color: Colors.black ,fontSize: 25,fontStyle:FontStyle.italic),),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 80,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),

                onPressed: (){

                },

                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("My City" ,
                  style: TextStyle(color: Colors.black ,fontSize: 25,fontStyle:FontStyle.italic),),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 80,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),

                onPressed: (){},

                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("Quiz" ,
                  style: TextStyle(color: Colors.black ,fontSize: 25,fontStyle:FontStyle.italic),),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
