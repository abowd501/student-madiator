import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Screens/Login.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';
import 'package:student_mediator/Screens/Profile.dart';

import 'Screens/Welcome.dart';

late SharedPreferences prefs;
 String? localhostip;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs=await SharedPreferences.getInstance();
  localhostip="192.168.81.181";
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:prefs.getString("Student_Id")==null?Welcome1():Nav_bar()
    );
  }
}


