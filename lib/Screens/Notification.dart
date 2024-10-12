
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Notification.dart';
import 'package:student_mediator/Services/NotificationApi.dart';

import '../main.dart';

class Notification1 extends StatefulWidget {
  const Notification1({super.key});

  @override
  State<Notification1> createState() => _NotificationState();
}

class _NotificationState extends State<Notification1> {
  String? id;
   List<NotificationModel>notData=[];
  NotificationApiService apiNotification=NotificationApiService();

  getData()async{
    notData=await apiNotification.fetchNotificationId(id!);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id= prefs.getString("Student_Id");
    _NotificationState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("الرسايل"),
          centerTitle: true,
      ),
     body: Directionality(
       textDirection: TextDirection.rtl,
       child: Container(
          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-3.png"),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
          //    color: Color(0xec574c47),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5,
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    FutureBuilder<List<NotificationModel>>(
                      future: apiNotification.fetchNotificationId(id!),
                      builder: (BuildContext context, AsyncSnapshot<List<NotificationModel>> snapshot) {
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.connectionState==ConnectionState.none){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.connectionState==ConnectionState.done){
                          if(snapshot.hasError){
                            return   Container(
                              height: MediaQuery.of(context).size.height*1.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('لايوجد انترنت',style: TextStyle(color: Colors.white),),
                                  Text(' 404',style: TextStyle(color: Colors.white,fontSize: 40),),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return Container(
                                // width: 250,
                                padding: const EdgeInsets.only(bottom: 5,top: 5),
                                margin:EdgeInsets.symmetric(horizontal: 1,vertical: 0.5),
                                decoration: BoxDecoration(
                                //  color:Color(0xbaffffff),
                                  // borderRadius: BorderRadius.circular(15),
                                  // boxShadow:[ BoxShadow(color: Color(0xc0bb8a52),blurRadius: 10,spreadRadius: 1,offset: Offset(2.0,2.0,))],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: Text("${snapshot.data?[index].notificationTime.split(" ").first}"),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.8,
                                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.15,top: 10 ),
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.brown.shade50,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${snapshot.data?[index].node}"),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${snapshot.data?[index].notificationTime.split(" ").last}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },);
                        }
                        return Center(child: Text("لا توجد رسائل"),);
                      },
                    ),
                    SizedBox(height: 40,)
                  ],
                ),

                ),
              ),
            ),
          ),
     ) ,
        // width: double.infinity,

      );

  }
}
