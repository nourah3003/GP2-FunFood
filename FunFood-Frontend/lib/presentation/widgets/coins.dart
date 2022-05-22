import 'package:flutter/material.dart';

Widget coins(Future<String>? coinsCount, Size size ) {
  return Container(
    margin: EdgeInsets.all(5),
    width: size.width*0.2,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width:size.width*0.1 ,
          height: size.height*0.07,
          child: Image.asset("assets/coins.png")),
        FutureBuilder<String>(
            initialData: "0",
            future: coinsCount,
            builder: (context, snapshot) {
              return Text(snapshot.data.toString(),
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),);
            })
      ],
    ),
  );
}
