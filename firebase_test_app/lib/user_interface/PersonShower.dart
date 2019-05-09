import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:firebase_test_app/model/MyRecords.dart';
import 'package:firebase_test_app/user_interface/UserDetails.dart';

class PersonShower extends StatefulWidget {
  PersonShower({Key key}) : super(key: key);

  @override
  PersonShowerState createState() => PersonShowerState();
}

class PersonShowerState extends State<PersonShower> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<UserRecord>> getRandomUserInfo() async {
    //get url
    var dataURL = await http.get("https://randomuser.me/api/?results=50");
    //decode url text body with jason.decode
    var myData = json.decode(dataURL.body);
    //store information of users in a list
    List<UserRecord> users = [];

    //Fetch data from results: Picture thumbnail, first name, last name and cellphone number
    for (var user in myData["results"]) {
      UserRecord userRecordData = UserRecord(
          user["picture"]["thumbnail"],
          user["name"]["first"],
          user["name"]["last"],
          user["cell"],
          user["picture"]["large"],
          user["dob"]["age"],
          user["location"]["street"],
          user["location"]["city"],
          user["email"]);
      users.add(userRecordData);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random Persons")),
      body: Container(
        child: FutureBuilder(
          future: getRandomUserInfo(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            if (snapShot.data == null) {
              return Container(
                child: Center(
                  child: Text("Fetching data..."),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapShot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.blue,
                      child: Column(
                        children: <Widget>[
                          Divider(height: 8.0),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapShot.data[index].thumbnail),
                            ),
                            title: Text(snapShot.data[index].firstName +
                                " " +
                                snapShot.data[index].lastName),
                            subtitle: Text(snapShot.data[index].phoneNumber),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserDetail(snapShot.data[index])));
                            },
                          ), //ListTile
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
