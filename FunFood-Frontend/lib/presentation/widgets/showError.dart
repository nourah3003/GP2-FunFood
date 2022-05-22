import 'package:flutter/material.dart';

void showMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.4,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text("OK",
                      style: TextStyle(color: Colors.white),),
                    ),
                  )),
            )
          ],
        );
      });
}
