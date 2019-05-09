import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test_app/service/firebase_firestore_service.dart';
import 'package:firebase_test_app/model/Info.dart';
import 'package:firebase_test_app/user_interface/Info_screen.dart';

class ListViewInfo extends StatefulWidget {
  @override
  _ListViewInfoState createState() => new _ListViewInfoState();
}

class _ListViewInfoState extends State<ListViewInfo> {
  List<InfoData> infoItems;
  //fire store instance, so that I can use it for managing my db data. E.g. delete and create
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  StreamSubscription<QuerySnapshot> infoSub;

  @override
  void initState() {
    super.initState();

    infoItems = new List();

    infoSub?.cancel();
    infoSub = db.getInfoList().listen((QuerySnapshot snapshot) {
      final List<InfoData> informationData = snapshot.documents
          .map((documentSnapshot) => InfoData.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.infoItems = informationData;
      });
    });
  }

  @override
  void dispose() {
    infoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Current user data"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: infoItems.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Card(
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 5.0),
                      ListTile(
                        title: Text(
                          '${infoItems[position].name}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        subtitle: Text("Born: " +
                          '${infoItems[position].yearOfBirth}\nlaptop model owned:\n${infoItems[position].computerModel}',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        leading: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(10.0)),
                            IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title: new Text("Are you sure you want to delete this?"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("Yes, delete it"),
                                              onPressed: () {
                                                deleteInfo(context, infoItems[position], position);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            )
                          ],
                        ),
                        onTap: () => navigateToInfo(context, infoItems[position]),
                      ),
                    ],
                  ),

                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => createNewInfo(context),
        ),
      ),
    );
  }

  void deleteInfo(BuildContext context, InfoData infDat, int position) async {
    db.deleteInfo(infDat.id).then((info) {
      setState(() {
        infoItems.removeAt(position);
      });
    });
  }

  void navigateToInfo(BuildContext context, InfoData infoData) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoScreen(infoData)),
    );
  }

  void createNewInfo(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoScreen(InfoData(null, "", "", 0))),
    );
  }
}