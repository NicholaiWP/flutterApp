import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),

      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Creator of app: ", textScaleFactor: 2.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Nicholai West Pedersen"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("About the project: ", textScaleFactor: 2.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Students first had to generate a list of 50 users with some of the information from 'randomuser.me'. \t"
                  "Additionally, another page was required so that the user in this page could use CRUD operations on the app using firebase"),
            ),
          ],
        ),
      ),
    );
  }
}