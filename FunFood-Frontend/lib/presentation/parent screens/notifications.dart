import 'package:flutter/material.dart';
import 'package:fun_food/presentation/widgets/showError.dart';

import '../../classes/api.dart';
import '../../main.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Future<List<dynamic>?>? items;
  @override
  void initState() {
    items = API.getUnaprovedMeals(user!.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: size.width,
              height: size.height,
              child: Image.asset(
                "assets/bascket.jpg",
                fit: BoxFit.cover,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.green.withOpacity(0.6),
                height: size.height * 0.2,
                child: SafeArea(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        )),
                    Text(
                      "Servings Confirm",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
              ),
              Expanded(
                  child: FutureBuilder<List<dynamic>?>(
                future: items,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(18),
                              alignment: Alignment.center,
                              height: size.height * 0.25,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.8),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Your child ate " +
                                          snapshot.data![index]["name"] +
                                          " at " +
                                          snapshot.data![index]["time"] +
                                          " " +
                                          "on " +
                                          snapshot.data![index]["date"] +
                                          " " +
                                          " do you want to confirm ?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Are you sure you want to confrim this meal?",
                                                          textAlign: TextAlign.center,),
                                                      content: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          
                                                          Container(
                                                            width: size.width*0.3,
                                                            height: size.height*0.1,
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.all(6),
                                                            decoration: BoxDecoration(

                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("No",
                                                              style: TextStyle(color: Colors.white),)),
                                                          ),
                                                          Container(
                                                            width: size.width*0.3,
                                                            height: size.height*0.1,
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.all(6),
                                                            decoration: BoxDecoration(

                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                    await API.approveMeal(
                                                  user!.userID,
                                                  snapshot.data![index]
                                                      ["serving_id"]);
                                              items = API.getUnaprovedMeals(
                                                  user!.userID);
                                              setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("Yes",style: TextStyle(color: Colors.white))),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).whenComplete(() {
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                              
                                            },
                                            icon: Icon(
                                              Icons.addchart_outlined,
                                              color: Colors.green,
                                              size: 40,
                                            )),
                                        IconButton(
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Are you sure you want to delete this item?",
                                                          textAlign: TextAlign.center,),
                                                      
                                                      content:Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                      children :  [
                                                             Container(
                                                           width: size.width*0.3,
                                                            height: size.height*0.1,
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.all(6),
                                                            decoration: BoxDecoration(

                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                          child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("No",style:TextStyle(color: Colors.white))),
                                                        ),
                                                        Container(
                                                           width: size.width*0.3,
                                                            height: size.height*0.1,
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.all(6),
                                                            decoration: BoxDecoration(

                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                          child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                ScaffoldMessenger
                                                                        .of(
                                                                            context)
                                                                    .showSnackBar(SnackBar(
                                                                        content: Text(await API.UnapproveMeal(
                                                                            user!
                                                                                .userID,
                                                                            snapshot.data![index]
                                                                                [
                                                                                "serving_id"]))));
                                                                items = API
                                                                    .getUnaprovedMeals(
                                                                        user!
                                                                            .userID);

                                                                setState(() {});

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("Yes",style: TextStyle(color: Colors.white),)),
                                                        ),
                                                   
                                                      ],)
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.delete_forever_rounded,
                                              color: Colors.red,
                                              size: 40,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }
                  return Center(
                      child: Container(
                          padding: EdgeInsets.all(18),
                          width: size.width * 0.5,
                          alignment: Alignment.center,
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(3, 0),
                                    blurRadius: 4,
                                    spreadRadius: 4,
                                    color: Colors.grey)
                              ]),
                          child: const Text(
                            "No Servings Yet !, Add some servings !",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )));
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
