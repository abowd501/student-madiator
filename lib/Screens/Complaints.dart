
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Complaints.dart';
import 'package:student_mediator/Screens/Profile.dart';
import 'package:student_mediator/Services/ComplaintsApi.dart';

import '../main.dart';

class Complaints extends StatefulWidget {
  const Complaints ({super.key});

  @override
  State<Complaints > createState() => _Edit_AccountState();
}

class _Edit_AccountState extends State<Complaints > {
  ComplaintsApiService apiComplaint=ComplaintsApiService();
  TextEditingController complaint=TextEditingController();
  List<ComplaintsModel> seardata=[];
  Future Apart()async{
    seardata=await  apiComplaint.fetchComplaintsId(id.toString());
  }
  String? id;
  getId()async{
    setState(() {
      id=  prefs.getString("Student_Id");
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
    Apart();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title:  Center(
          child: Text("الدعم الفني",style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        ),
        leading:                    IconButton(
          onPressed: (){ Navigator.pop(context, MaterialPageRoute(builder: (context)=>Profile()));},
          icon:Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Directionality(

        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Container(
              color: Colors.brown.withOpacity(0.3),
             // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      //height: 700,
                      //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom*0.5),
                      child: SingleChildScrollView(
                        reverse: true,
                        dragStartBehavior: DragStartBehavior.down,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FutureBuilder<List<ComplaintsModel>>(
                              future: apiComplaint.fetchComplaintsId(id.toString()),
                              builder: (BuildContext context, AsyncSnapshot<List<ComplaintsModel>> snapshot) {
                                if(snapshot.connectionState==ConnectionState.waiting){
                                  return CircularProgressIndicator();
                                }
                                if(snapshot.connectionState==ConnectionState.done){
                                  if(snapshot.hasError){
                                    return  Container(
                                      height: MediaQuery.of(context).size.height*1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('لايوجد انترنت',style: TextStyle(color: Colors.red),),
                                          Text(' 404',style: TextStyle(color: Colors.red,fontSize: 40),),
                                        ],
                                      ),
                                    );
                                  }
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      // reverse: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: seardata.length,
                                      itemBuilder: ( context, index) {
                                        return  Container(

                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                          margin: EdgeInsets.only(left: 40,bottom: 20),
                                          width: double.infinity,
                                          //height: 500,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Center(
                                            child: Text("${seardata[index].complaint}",
                                              style: TextStyle(
                                                  fontSize: 15
                                              ),),
                                          ),
                                        );
                                      },

                                    );
                                  }
                                }
                                return Center();
                              },

                            ),
                            SizedBox(height: 20,),

                          ],

                        ),
                      ),
                    ),
                  ),Container(
                    // height: 800,
                    // margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextFormField(
                      controller: complaint,
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          prefixIconColor: Colors.white12,
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          label: Center(child: Text("اكتب رسالتك هنا")),
                          suffixIcon: InkWell(
                            onTap: () async {
                              ComplaintsModel data=ComplaintsModel(complaintId: '0',complaint: complaint.text, complaintTime: 'complaintTime', studentId: id.toString());
                              if(complaint.text.isNotEmpty){
                               await apiComplaint.addComplaints(data, context);
                                complaint.clear();
                                setState(() {
                                  Apart();
                                });
                              }

                            },
                            child: CircleAvatar(
                                backgroundColor: Colors.brown,
                                child: Icon(Icons.send,color: Colors.white,size: 20,)),
                          )
                        //prefixIcon: Icon(Icons.person)
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
                ],
              ),
            ),
          ) ,
          // width: double.infinity,

        ),
      ),
    );
  }
}






class Suport extends StatefulWidget {
  const Suport ({super.key});

  @override
  State<Suport > createState() => _Suport();
}

class _Suport extends State<Suport> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        width: double.infinity,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage("images/apartment/aparment-3.png"),
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x61bb8a52),
          ),
          child: Container(
            color: Colors.white.withOpacity(0.5),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){ Navigator.pop(context, MaterialPageRoute(builder: (context)=>Profile()));},
                          icon:Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Text("الدعم الفني",style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox()

                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    Center(
                      child: Form(
                        child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: Text("اذا كان لديك اي مشكلة لا تتردد في طرحها علينا",
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                             // height: 800,
                              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xb3ffffff) ,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      maxLines: 12,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        prefixIconColor: Colors.white12,
                                        floatingLabelStyle: TextStyle(color: Colors.black),
                                        label: Center(child: Text("اكتب رسالتك هنا")),
                                        //prefixIcon: Icon(Icons.person)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  SizedBox(
                                    height: 55,
                                    width: 170,
                                    child: ElevatedButton(
                                      onPressed: (){
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          side: BorderSide.none,
                                          shape: const StadiumBorder(),
                                          onPrimary: Colors.black,
                                          primary: Color(0xffbb8a52)

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("ارسال",style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white
                                        ),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ],

                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ,
        // width: double.infinity,

      ),
    );
  }
}