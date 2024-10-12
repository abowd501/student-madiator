import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Vehicle.dart';
import 'package:student_mediator/Screens/Vehical.dart';
import 'package:student_mediator/Screens/Vehical_Owner.dart';
import 'package:student_mediator/Services/VehicleApi.dart';

import '../main.dart';
import 'Apartment.dart';
import 'Home.dart';

class Nav_bar extends StatefulWidget {
  @override
  State<Nav_bar> createState() => _Nav_barState();
}

class _Nav_barState extends State<Nav_bar> {
  int _selectIndex=0;
  String? tr;
  final _screen=[
    //home screen
    Home(),
    //schedule screen
    Apartment(),
    // messages screen
    Vehical(),
  ];
  final _screen1=[
    //home screen
    Home(),
    //schedule screen
    Apartment(),
    //setting screen
    Vehical_Owner(),
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tr=prefs.getString("Role_Id");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          extendBody: true,
          body: tr.toString()=='1'?_screen[_selectIndex]:_screen1[_selectIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color:Colors.brown.shade50,
            backgroundColor: Colors.transparent,
           buttonBackgroundColor:Colors.brown ,
            onTap: (index){
              setState((){
                _selectIndex=index;
              });},
            items: [
              Icon(Icons.home_outlined,color: _selectIndex==0?Colors.white: Colors.brown,size: 40,),
              Icon(Icons.home_work_outlined,color: _selectIndex==1?Colors.white: Colors.brown,size: 40,),
              Icon(CupertinoIcons.car_detailed,color: _selectIndex==2?Colors.white: Colors.brown,size: 40,),


            ],

           // color: Colors.white,
          ),
        ),
      ),
    ) ;
  }



}

