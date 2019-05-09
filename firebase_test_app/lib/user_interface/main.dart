import 'package:flutter/material.dart';
import 'package:firebase_test_app/model/SettingsConstants.dart';
import 'package:firebase_test_app/user_interface/PersonShower.dart';
import 'package:firebase_test_app/user_interface/AboutPage.dart';
import 'package:firebase_test_app/model/Info.dart';
import 'package:firebase_test_app/user_interface/listview_info.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String welcomeScreen = "Welcome! :-)";

  BuildContext cont;
  InfoData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              cont = context;
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              child: UserAccountsDrawerHeader(
                accountName: Text("Random User Name"),
                accountEmail: Text("RandomEmail@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      //Change app theme based on target platform
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "?",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Random persons"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonShower()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.wifi),
              title: Text("Edit a user's data"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewInfo()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Welcome to my app!", textScaleFactor: 2.0),
          )),
    );
  }

  void choiceAction(String choice) {
    if(choice == Constants.about){
      Navigator.push(cont,MaterialPageRoute(builder: (context) => About()));
    }
  }
}
