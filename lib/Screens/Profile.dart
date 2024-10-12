
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Screens/Edit_Account.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';

import '../Model/Student.dart';
import '../Services/StudentApi.dart';
import '../main.dart';
import 'Home.dart';

class Profile extends StatefulWidget {
  const Profile( {super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StudentApiService apiStudent=StudentApiService();
  @override
  String? userImage="http://$localhostip/Api_Student_m/Images/Students/";
  String? tr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tr= prefs.getString("Student_Id")??"nulll";
  }
  Widget build(BuildContext context) {

    return  Material(
        child: Container(
        width: double.infinity,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.brown.shade50,

    ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text("الملف الشخصي",style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),), IconButton(
                            onPressed: (){ Navigator.pop(context);},
                            icon:Icon(CupertinoIcons.arrow_left),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    FutureBuilder<List<StudentModel>>(
                      future: apiStudent.fetchStudentId(tr.toString()),
                      builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot) {
                        var ss=snapshot.data?.first ;//where((element) => element.studentId==tr.toString()).first;
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.connectionState==ConnectionState.none){
                          return Text("data");
                        }
                        if(snapshot.connectionState==ConnectionState.done){
                        if(snapshot.hasData&&snapshot.data!.isNotEmpty){
                          return Column(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(200),
                                          child:ss!.image!.isImageFileName? Image.network("$userImage${ss?.image}"):Image.asset("images/app/person.png",fit: BoxFit.cover,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("${ss.name}",style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Divider(
                                        height: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child:ListTile(
                                  title:Text("ُالايميل",style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle:Text("${ss.email}"),
                                  leading: Icon(CupertinoIcons.mail_solid,color: Colors.brown,),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:ListTile(
                                      title:Text(" الاسم",style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle:Text("${ss.name}"),
                                      leading: Icon(CupertinoIcons.person_alt,color: Colors.brown,),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:ListTile(
                                      title:Text(" الرقم",style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle:Text("${ss.phone}"),
                                      leading: Icon(CupertinoIcons.phone_circle_fill,color: Colors.brown,),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:ListTile(
                                      title:Text("الكلية",style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle:Text("${ss.collage}"),
                                      leading: Icon(CupertinoIcons.collections_solid,color: Colors.brown,),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:ListTile(
                                      title:Text(" المستوى",style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle:Text("${ss.level}"),
                                      leading: Icon(CupertinoIcons.location_solid,color: Colors.brown,),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:ListTile(
                                      title:Text(" االعنوان",style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle:Text("${ss.address}"),
                                      leading: Icon(CupertinoIcons.location_solid,color: Colors.brown,),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.46,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:ListTile(
                                      title:Text("  الهاتف",style: TextStyle(fontWeight: FontWeight.bold)),
                                      subtitle:Text("${ss.phone}",style: TextStyle(fontWeight: FontWeight.bold),),
                                      leading: Icon(CupertinoIcons.phone_fill,color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                     await Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account(ss)));
                                     setState(() {
                                     });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        side: BorderSide.none,
                                        shape: const StadiumBorder(),
                                        onPrimary: Colors.black,
                                        primary: Colors.brown
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("تعديل الملف",style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }}
                        return Center();
                      },

                    ),


                  ],
                ),
            ),
            ),
          ) ,
           // width: double.infinity,

        ),
    );

  }
}
