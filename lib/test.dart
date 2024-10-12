import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_mediator/Model/Student.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController dep = TextEditingController();
StudentModel ser=StudentModel(
    name:" 444",
    email: "333",
    level: "555",
    studentId: '1',
    password: '4545',
    phone: '45',
    collage: '4566',
    address: 'wewr',
    rugsNum: 'jhf',
    image: 'kjh',
    roleId: 'jh'
);
  void postData() async {
    var url = "http://192.168.43.195/Api_Student_m/SignUp.php";
    int ag = int.tryParse(level.text) ?? 0;
    int lev = int.tryParse(level.text) ?? 0;
    var res = await http.post(Uri.parse(url), body: ser.toJson());

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Donr insert.....")));
      //var route = MaterialPageRoute(builder: (context) => ViewData());
      //Navigator.of(context).push(route);
    } else {
      print("Erorr");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("name"),
              ),
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(top: 0, right: 20.0, left: 20.0, bottom: 10.0),
            child: TextField(
              controller: age,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("age"),
              ),
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(top: 0, right: 20.0, left: 20.0, bottom: 10.0),
            child: TextField(
              controller: level,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("level"),
              ),
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(top: 0, right: 20.0, left: 20.0, bottom: 10.0),
            child: TextField(
              controller: dep,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("department"),
              ),
            ),
          ),
          MaterialButton(
              color: Colors.blueAccent,
              child: Text(
                "Send",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                postData();
              })
        ],
      ),
    );
  }
}
