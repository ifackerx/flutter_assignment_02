import 'dart:core';

import 'package:flutter_assignment_02/data/db.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return home_state();
  }
}

class home_state extends State<home> {
  static TodoProvider todo = TodoProvider();
  
  int count1, count2 = 0;
  List<Todo> div1, div3, box = [];

  int _state = 0;
  @override
  Widget build(BuildContext context) {
    final List list_button = <Widget>[
      IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/screen");
        },
      ),
      IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: () async {
          box = div3;
          var del = await todo.getAllString();
          for (var item in del) {
            if (item.values.toList()[2] == 1) {
              await todo.delete(item.values.toList()[0]);
              for (var i = 0; i < div3.length; i++) {
                if (div3[i].id == item.values.toList()[0]) {
                  await box.removeAt(i);
                }
              }
            }
          }
          setState(() {
            div3 = [];
          });
        },
      )
    ];

    return DefaultTabController(
      length: 2,
      initialIndex: _state,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: Text(
              "Todo",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[list_button[_state]],
          ),
          backgroundColor: Colors.white,
          body: _state == 0
              ? Container(
                  color: Colors.white,
                  child: FutureBuilder<List<Todo>>(
                    future: todo.getAll(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Todo>> snapshot) {
                      div1 = [];
                      count1 = 0;
                      if (snapshot.hasData) {
                        for (var items in snapshot.data) {
                          if (items.done == false) {
                            div1.add(items);
                            count1++;
                          }
                        }
                        return count1 != 0
                            ? ListView.builder(
                                itemCount: div1.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Todo item = div1[index];
                                  return Column(children: <Widget>[ListTile(
                                    title: Text(item.title),
                                    trailing: Checkbox(
                                      onChanged: (bool value) async {
                                        setState(() {
                                          item.done = value;
                                        });
                                        todo.update(item);
                                      },
                                      value: item.done,
                                    ),
                                  ),Divider(color: Colors.white,)],);
                                },
                              )
                            : Center(
                                child: Text("No Data Found... ",
                                              style: TextStyle(color: Colors.black),),
                                
                              );
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white));
                      }
                    },
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: FutureBuilder<List<Todo>>(
                    future: todo.getAll(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Todo>> snapshot) {
                      div3 = [];
                      count2 = 0;
                      if (snapshot.hasData) {
                        for (var items in snapshot.data) {
                          if (items.done == true) {
                            div3.add(items);
                            count2++;
                          }
                        }
                        return count2 != 0
                            ? ListView.builder(
                                itemCount: div3.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Todo item = div3[index];
                                  return Column(
                                    children: <Widget>[
                                       ListTile(
                                    
                                    title: Text(item.title),
                                    trailing: Checkbox(
                                      onChanged: (bool value) async {
                                        setState(() {
                                          item.done = value;
                                        });
                                        todo.update(item);
                                      },
                                      value: item.done,
                                    ),
                                  ),Divider(color: Colors.white,)
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text("No Data Found..."),
                              );
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white));
                      }
                    },
                  ),
                ),
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.black,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.white))),
            child: BottomNavigationBar(
              fixedColor: Colors.blue,
              currentIndex: _state,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: new Icon(Icons.format_list_bulleted),
                  title: Text("Task"),
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: new Icon(Icons.done_all),
                  title: Text("Complete"),
                ),
              ],
            ),
          )),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      todo.open("todo.db");
      _state = index;
    });
  }
}
