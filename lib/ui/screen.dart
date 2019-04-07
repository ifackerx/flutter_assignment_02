import 'package:flutter_assignment_02/data/db.dart';
import 'package:flutter/material.dart';

class screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return screen_state();
  }
}

class screen_state extends State<screen> {

  String _title;
  final myController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
 
  TodoProvider todo = TodoProvider();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomPadding: false, backgroundColor: Colors.white,
      
      appBar: AppBar(
         title: Text(
          "New Subject",
          style: TextStyle(color: Colors.white),
        ),
        
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue,
        centerTitle: true,
       
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  controller: myController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Subject :",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill Subject";
                    } else {
                      _title = value;
                    }
                  },
                ),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: Colors.blue,
                    child: Text("Save"),
                    onPressed: () async {
                      _formkey.currentState.validate();
                      
                      if (_title.length > 0) {
                        await todo.open("todo.db");
                        Todo data = Todo();
                        data.title = _title;
                        data.done = false;
                        await todo.insert(data);
                        myController.text = "";
                        passed();
                      }
                    
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void passed() {
    // flutter defined function
    Navigator.of(context).pop();
    
  }
}
