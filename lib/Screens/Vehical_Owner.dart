

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Booking.dart';
import 'package:student_mediator/Model/Student.dart';
import 'package:student_mediator/Services/BookingApi.dart';
import 'package:student_mediator/Services/StudentApi.dart';
import 'package:student_mediator/Services/VehicleApi.dart';

import '../main.dart';
import 'Vehical.dart';

class Vehical_Owner extends StatefulWidget {
  const Vehical_Owner({super.key});

  @override
  State<Vehical_Owner> createState() => _Vehical_OwnerState();
}

class _Vehical_OwnerState extends State<Vehical_Owner> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(height: 5),
         //----------------------------------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Colors.brown,
                      borderRadius:BorderRadius.circular(20.0),
                    ),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text("الركاب",style: TextStyle(
                          fontSize: 18,
                         // color: Colors.white
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text("الطلبات",style: TextStyle(
                          fontSize: 18,
                        //  color: Colors.black
                        ),),
                      ),

                    ],
                  ),
                ),
                Expanded(
                    child:TabBarView(
                      children: [
                        Users(),
                        Request()
                      ],
                    )
                ),
              ],
            ),
          ) ,
          // width: double.infinity,

        ),
      ),
    );
  }
}


class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  BookingApiService apiBooking=BookingApiService();
  StudentApiService apiStudent=StudentApiService();
  String? userImage="http://${localhostip.toString()}/Api_Student_m/Images/Students/";
  String? tr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tr=  prefs.getString("Vehicle_Id");
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(
           // width: double.infinity,
           // padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ]
            ),
            child: Center(
              child: Text("كل الركاب",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )
              ),
            ),
          ),
         SizedBox(height: 5,),
          FutureBuilder<List<BookingModel>>(
            future: apiBooking.fetchBooking("1",tr.toString()),
            builder: (BuildContext context, AsyncSnapshot<List<BookingModel>> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){ return CircularProgressIndicator();}
              if(snapshot.connectionState==ConnectionState.done){
                if(snapshot.hasError){
                  return Container(
                    color: Colors.white70,
                    height: 700,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('لايوجد انترنت',style: TextStyle(color: Colors.red),),
                          Text(' 404',style: TextStyle(color: Colors.red,fontSize: 40),),
                        ],
                      ),
                    ),
                  );
                }
                if(snapshot.hasData){
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:int.parse(snapshot.data!.length.toString()),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      var data=snapshot.data?[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              )
                            ]
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              FutureBuilder<List<StudentModel>>(
                                future: apiStudent.fetchStudentId(data!.studentId.toString()),
                                builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot2) {
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return CircularProgressIndicator();
                                  }
                                  return ListTile(
                                    title: Text(
                                      "${snapshot2.data?[0].name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text("${snapshot2.data?[0].email}"),
                                    trailing: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage("$userImage${snapshot2.data?[0].image}"),
                                    ),
                                  );
                                },

                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  thickness: 1,
                                  height: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${data?.bookTime?.split(" ").last}",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.black54,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${data?.bookTime?.split(" ")[1]}",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text( "لدية حجز ",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  InkWell(
                                    onTap: () async {
                                      await showDialog(context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          icon: Icon(Icons
                                              .delete,
                                            color: Colors.red,),
                                          title: Text(
                                            "تأكيد الحذف",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors
                                                    .black),
                                          ),
                                          content: Text(
                                            "هل تريد حذف  هذا الشخص من مركبتك الان",
                                            style: TextStyle(
                                                fontSize: 15),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                        side: BorderSide
                                                            .none,
                                                        shape: const StadiumBorder(),
                                                        onPrimary: Colors
                                                            .black,
                                                        primary: Colors
                                                            .white
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(
                                                          8.0),
                                                      child: Text(
                                                        "ألغاء",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          //   color: Colors.black
                                                        ),),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      var dd=await apiBooking.deleteBooking(data!.bookingId.toString());
                                                      if(dd){
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم الخذف ")));
                                                        //Navigator.pop(context, MaterialPageRoute(builder: (context)=>Vehical()));
                                                      }
                                                      if(dd==false){
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("لم بتم الخذف ")));
                                                        // Navigator.pop(context);
                                                      }
                                                      print(dd);
                                                    },
                                                    style: ElevatedButton.styleFrom(side: BorderSide.none,
                                                        shape: const StadiumBorder(),
                                                        onPrimary: Colors
                                                            .white,
                                                        primary: Colors
                                                            .brown
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(
                                                          8.0),
                                                      child: Text(
                                                        "تأكبد",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          // color: Colors.black
                                                        ),),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],

                                        );

                                      });
                                    },
                                    child: Container(
                                      width: 130,
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color:  Colors.brown,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text("الغاء الحجز",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                            ],
                          ),
                        ),
                      );
                    },);
                }
              }
              return Center();
            },

          ),

       //   SizedBox(height: 20),

        ],
      ),
    );
  }
}


class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  BookingApiService apiBooking=BookingApiService();
  StudentApiService apiStudent=StudentApiService();
  String? userImage="http://$localhostip/Api_Student_m/Images/Students/";
  String? tr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tr= prefs.getString("Vehicle_Id");

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ]
            ),
            child: Center(
              child: Text("الطلبات",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )
              ),
            ),
          ),
        SizedBox(height: 5,),

          tr!.isNotEmpty?
          FutureBuilder<List<BookingModel>>(
            future: apiBooking.fetchBooking("0",tr!),
            builder: (BuildContext context, AsyncSnapshot<List<BookingModel>> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(snapshot.connectionState==ConnectionState.done){
                if(snapshot.hasError){
                  return Container(
                    color: Colors.white24,
                    height: 700,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('لايوجد انترنت',style: TextStyle(color: Colors.red),),
                          Text(' 404',style: TextStyle(color: Colors.red,fontSize: 40),),
                        ],
                      ),
                    ),
                  );
                }
                if(snapshot.hasData){
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      var data=snapshot.data?[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              )
                            ]
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              FutureBuilder<List<StudentModel>>(
                                future: apiStudent.fetchStudentId(data!.studentId.toString()),
                                builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot2) {
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return CircularProgressIndicator();
                                  }
                                  return ListTile(
                                    title: Text(
                                      "${snapshot2.data?[0].name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text("${snapshot2.data?[0].email}"),
                                    trailing: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage("$userImage${snapshot2.data?[0].image}"),
                                    ),
                                  );
                                },

                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  thickness: 1,
                                  height: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${data?.bookTime?.split(" ").last}",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.black54,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${data?.bookTime?.split(" ")[1]}",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text( " تحت الطلب ",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  InkWell(
                                    onTap: ()async{
                                      var dd=await apiBooking.updateBooking(data!.bookingId.toString());
                                      if(dd){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم القبول ")));
                                        setState(() {

                                        });
                                        // Navigator.pop(context, MaterialPageRoute(builder: (context)=>Vehical()));
                                      }
                                      if(dd==false){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("  هناك مشكلة ")));
                                        // Navigator.pop(context);
                                      }
                                      print(dd);
                                    },
                                    child: Container(
                                      width: 130,
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color:  Colors.brown,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text("قبول",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      await showDialog(context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              icon: Icon(Icons
                                                  .delete,
                                                color: Colors.red,),
                                              title: Text(
                                                "تأكيد الحذف",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors
                                                        .black),
                                              ),
                                              content: Text(
                                                "هل تريد حذف  هذا الشخص من مركبتك الان",
                                                style: TextStyle(
                                                    fontSize: 15),
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            side: BorderSide
                                                                .none,
                                                            shape: const StadiumBorder(),
                                                            onPrimary: Colors
                                                                .black,
                                                            primary: Colors
                                                                .white
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .all(
                                                              8.0),
                                                          child: Text(
                                                            "ألغاء",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              //   color: Colors.black
                                                            ),),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          var dd=await apiBooking.deleteBooking(data!.bookingId.toString());
                                                          if(dd){
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم الخذف ")));
                                                            //Navigator.pop(context, MaterialPageRoute(builder: (context)=>Vehical()));
                                                            Navigator.pop(context);
                                                            setState(() {

                                                            });
                                                          }
                                                          if(dd==false){
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("لم بتم الخذف ")));
                                                             Navigator.pop(context);
                                                          }
                                                          print(dd);
                                                        },
                                                        style: ElevatedButton.styleFrom(side: BorderSide.none,
                                                            shape: const StadiumBorder(),
                                                            onPrimary: Colors
                                                                .white,
                                                            primary: Colors
                                                                .brown
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .all(
                                                              8.0),
                                                          child: Text(
                                                            "تأكبد",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              // color: Colors.black
                                                            ),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],

                                            );

                                          });
                                    },
                                    child: Container(
                                      width: 130,
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color:  Colors.black38,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text("رفض",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },);
                }

              }
              return Center();
            },

          ):
              Container(
                color: Colors.white12,
                height: double.infinity,
              )
        //  SizedBox(height: 20),

        ],
      ),
    );
  }
}




