import 'package:flutter/material.dart';
import 'package:firebase_test_app/model/Info.dart';
import 'package:firebase_test_app/service/firebase_firestore_service.dart';

class InfoScreen extends StatefulWidget {
  final InfoData data;
  InfoScreen(this.data);

  @override
  State<StatefulWidget> createState() => new InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController birthController;
  TextEditingController laptopController;

  @override
  void initState() {
    super.initState();

    nameController = new TextEditingController(text: widget.data.name);
    birthController = new TextEditingController(text: widget.data.yearOfBirth.toString());
    laptopController = new TextEditingController(text: widget.data.computerModel);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Information page')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input){
                    if(input.isEmpty){
                      return "Entering a name is required";
                    }
                    else if(input is int){
                      return "Your name does not contain numbers, try again!";
                    }
                  },
                  onSaved: (input){
                    nameController.text = input;
                  },
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Enter your name:'),
                ),
                Padding(padding: new EdgeInsets.all(5.0)),
                TextFormField(
                  onSaved: (input){
                    birthController.text = input;
                  },
                  validator: (input){
                    if(input.isEmpty){
                      return "You must enter the year you were born";
                    }
                    else if(int.parse(input) >= 2070 || int.parse(input) <= 1960 || int.parse(input) == 0){
                      return "That can't be right, the yeaar must be in range of 1960-2070";
                    }
                  },
                  controller: birthController,
                  decoration: InputDecoration(labelText: "Enter your year of birth with format 'XXXX'"),
                ),
                TextFormField(
                  validator: (input){
                    if(input.isEmpty){
                      return "Entering your owned laptop name is required";
                    }
                  },
                  onSaved: (input){
                    laptopController.text = input;
                  },
                  controller: laptopController,
                  decoration: InputDecoration(labelText: "Enter the name of the laptop you own:"),
                ),

                Padding(padding: new EdgeInsets.all(5.0)),
                //if data is already added, use edit data text button
                RaisedButton(
                  child: (widget.data.id != null) ? Text('Edit') : Text('Add'),
                  onPressed: () {
                    if(formKey.currentState.validate()){
                      if (widget.data.id != null) {
                        db
                            .updateInfo(
                            InfoData(widget.data.id, nameController.text, laptopController.text, int.parse(birthController.text)))
                            .then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        db.createInfo(nameController.text, laptopController.text, birthController.text).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    }
                  },
                ),
              ]
          ),
        ),
      ),
    );
  }
}