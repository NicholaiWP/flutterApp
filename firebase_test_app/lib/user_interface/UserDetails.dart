import 'package:flutter/material.dart';
import 'package:firebase_test_app/model/MyRecords.dart';

class UserDetail extends StatelessWidget{

  final UserRecord user;
  final String userAgeString = "Age of user: ";
  final String location = "User location: ";
  final String mail = "Contact mail: ";

  UserDetail(this.user);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.firstName + " " + user.lastName),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Card(
                child: Image.network(user.picture, fit: BoxFit.fill),
              ),
              Text(userAgeString + user.age.toString()),
              Text(location + user.city + ", " + user.street),
              Text(mail + user.email),
            ],
          ),
        ),
      ),
    );
  }
}
