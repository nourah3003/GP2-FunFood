import 'package:flutter/material.dart';
import 'dart:math';

class SwipeDeleteDemo extends StatefulWidget {
  SwipeDeleteDemo() : super();

  final String title = "Refresh/Swipe Delete Demo";

  @override
  SwipeDeleteDemoState createState() => SwipeDeleteDemoState();
}

class SwipeDeleteDemoState extends State<SwipeDeleteDemo> {
  //
  List<String> companies;
  GlobalKey<RefreshIndicatorState> refreshKey;
  Random r;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    r = Random();
    companies = List();
    addCompanies();
  }

  addCompanies() {
    companies.add("Banana");
    companies.add("Apple");
    companies.add("Orange");
    companies.add("Mango");
    companies.add("Fig");
  }

  addRandomCompany() {
    int nextCount = r.nextInt(100);
    setState(() {
      companies.add("Company $nextCount");
    });
  }

  removeCompany(index) {
    setState(() {
      companies.removeAt(index);
    });
  }

  undoDelete(index, company) {
    setState(() {
      companies.insert(index, company);
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 10));
    addRandomCompany();
    return null;
  }

  showSnackBar(context, company, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$company deleted'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          undoDelete(index, company);
        },
      ),
    ));
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: companies.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
      },
    );
  }

  Widget row(context, index) {
    return Dismissible(
      key: Key(companies[index]), // UniqueKey().toString()
      onDismissed: (direction) {
        var company = companies[index];
        showSnackBar(context, company, index);
        removeCompany(index);
      },
      background: refreshBg(),
      child: Card(
        child: ListTile(
          title: Text(companies[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: friuts(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: list(),
      ),
    );
  }
}