import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MainSc extends StatefulWidget {
  final int count;

  MainSc({Key key, @required this.count}) : super(key: key);
  Addtodo createState() {
    // TODO: implement createState
    return Addtodo();
  }
}

class Addtodo extends State<MainSc> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 30, 25, 30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Subject",
                  hintText: "Please fill Subject",
                  // icon: Icon(Icons.person),
                ),
                controller: _title,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill Subject";
                  }
                },
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {

                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    CollectionReference reference =
                        Firestore.instance.collection('todo');

                    await reference
                        .add({"_id": widget.count + 1, "title": _title.text, "done": 0});
                    _title.clear();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}