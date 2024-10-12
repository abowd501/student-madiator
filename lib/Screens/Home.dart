import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_mediator/Model/Feedback.dart';
import 'package:student_mediator/Model/Student.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';
import 'package:student_mediator/Screens/Profile.dart';
import 'package:student_mediator/Screens/Settings.dart';
import 'package:student_mediator/Screens/Notification.dart';
import 'package:student_mediator/Services/AdsApi.dart';
import 'package:student_mediator/Services/FeedbackApi.dart';
import 'package:student_mediator/Services/StudentApi.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Services/ApartmentApi.dart';
import '../main.dart';
import 'Apartment_Details.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String? tr;
  String? role;
  get(){

      tr=prefs.getString("Student_Id");
      role= prefs.getString("Role_Id");

  }
  String? userImage="http://${localhostip.toString()}/Api_Student_m/Images/Students/";
  String? apartmentImage="http://${localhostip.toString()}/Api_Student_m/Images/apartment/";
  String? adsImage="http://${localhostip.toString()}/Api_Student_m/Images/Ads/";


  ApartmentApiService apiAprtment=ApartmentApiService();
  AdsApiService apiAds=AdsApiService();
  FeedbackApiService apiFeedback=FeedbackApiService();
  StudentApiService apiStudent=StudentApiService();
int myacount=0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      get();
    });

  }
  @override
  Widget build(BuildContext context) {
    get();
    return Container(
      width: double.infinity,
     // height:800,
      decoration: BoxDecoration(
        image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
           // fit: BoxFit.cover),
     fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                        color: Colors.black26
                      ),
                      child: ads(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        children: [
                          InkWell(
                          onTap: (){
                              customSigninDialog(context,role,onCLosed: (_) {
                                    setState(() {});
                                    },);},
                              child: Icon(Icons.settings_outlined,size: 30,color: Colors.white,)),
                          SizedBox(height: 30,),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Notification1()));
                              },
                              child: Icon(Icons.notifications_paused_outlined
                                ,size: 30,color: Colors.white,)),
                          SizedBox(height: 30,),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Profile()));
                              },
                              child: Icon(CupertinoIcons.person_fill
                                ,size: 30,color: Colors.white,)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:  Center(child: Text("الوسيط الطلابي",style: TextStyle(fontSize: 20),)),
                ),
              ],
            ),
            ),
            Container(
              //height: 800,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.8),
                borderRadius: BorderRadius.only(topRight:Radius.circular(60),topLeft:Radius.circular(60))
              ),
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("مضاف حديثا" ,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),
                       SizedBox(),
                      ],
                    ),
                    SizedBox(height: 220,

                      child: FutureBuilder<List>(
                        future: apiAprtment.fetchApartment(),
                        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if(snapshot.connectionState==ConnectionState.done){
                            if(snapshot.hasError){
                              return Center(
                                child: Text('لايوجد انترنت'),
                              );
                            }
                            return ListView.builder(
                              //reverse: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                //shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          Apartment_Details(snapshot.data![index].apartmentId.toString())));
                                    },
                                    child: Container(
                                      margin:EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width*0.42,
                                      height: MediaQuery.of(context).size.width*0.5,
                                      decoration: BoxDecoration(
                                        color:Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [BoxShadow(blurRadius: 10, color: Color(0xddb0b0b0), spreadRadius: 1)],

                                      ),
                                      child: Column(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.width * 0.32,
                                            decoration: BoxDecoration(
                                              color: Colors.black38,
                                              borderRadius: BorderRadius.circular(20),
                                              image:DecorationImage(image: NetworkImage("$apartmentImage${snapshot.data![index].images?.split(",").first.split(" ").last}"),fit: BoxFit.cover),
                                            ),

                                          ),
                                          Row(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("${snapshot.data![index].location}",style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text("${snapshot.data![index].price}",style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.bathtub_rounded,semanticLabel: "hjk"),
                                              Text('${snapshot.data![index].numBith}'),
                                              Icon(Icons.room_preferences),
                                              Text('${snapshot.data![index].numRoom}'),
                                              Icon(Icons.account_balance),
                                              Text('${snapshot.data![index].floor}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },

                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("أراء العملاء" ,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: InkWell(
                              onTap: (){
                                //FeedBack(context,onCLosed: (_) {setState(() {});},);
                                showDialog(context: context,
                                  builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    actionsPadding: EdgeInsets.all(20),
                                    backgroundColor: Colors.brown,
                                    actions: [
                                      FeedBackBody()
                                    ],
                                  );
                                  },
                                );
                                },
                              child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("أضافة تعليق",style: TextStyle(color: Colors.black),),
                              Icon(CupertinoIcons.add_circled_solid) ,
                            ],
                          )),

                        )
                      ],
                    ),
                    FutureBuilder<List<FeedbackModel>>(
                      future: apiFeedback.fetchFeedback(),
                      builder: (BuildContext context,  snapshot) {
                        if (snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.connectionState==ConnectionState.done){
                          if(snapshot.hasError){
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0),
                                child: Text("لايوجد انترنت"),
                              ),
                            );
                          }if(snapshot.hasData){
                          return ListView.builder(
                           // reverse: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:snapshot.data!.length<=10?snapshot.data!.length:10,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return Container(
                                // height: 200,
                                width: 200,
                                padding: const EdgeInsets.only(bottom: 5,top: 5),
                                margin:EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow:[ BoxShadow(color: Color(0xffdcdbdb),blurRadius: 10,spreadRadius: 1,offset: Offset(2.0,2.0,))],
                                ),
                                child: Column(
                                  children: [
                                    FutureBuilder<List<StudentModel>>(
                                      future: apiStudent.fetchStudentId(snapshot.data![index].studentId.toString()),
                                      builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot1) {
                                        if(snapshot.connectionState==ConnectionState.waiting){
                                          return CircularProgressIndicator();
                                        }
                                       // int sd=int.parse( snapshot.data![index].studentId.toString());
                                        var s=snapshot1.data?.first;
                                        if(snapshot1.connectionState==ConnectionState.done){
                                          if(snapshot1.hasError){
                                            return Center();
                                          }
                                        return ListTile(
                                            onTap: (){
                                            },
                                            leading: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                "$userImage${s?.image}",

                                              ),
                                            //  child: Image.network("http://192.168.43.195/Api_Student_m/Images/Students/doctor2.jpg"),

                                            ),
                                            title: Text("${s?.name} ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,

                                              ),
                                            ),
                                            subtitle: Text("${s?.email}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            trailing: Column(
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].feedbackTime?.split(" ").last}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );}

                                        return Center();

                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                     "${snapshot.data![index].feedback}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },);
                        }}
                        return CircularProgressIndicator();
                      },

                    ),

                  ],
                ),
            ),
          ],
        ),
      ),

    );
  }
}


Future<Object?>FeedBack(BuildContext context, {required ValueChanged onCLosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.28, horizontal: MediaQuery.of(context).size.width*0.1),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FeedBackBody(),
      ),
    ),
  ).then(onCLosed);
}


class FeedBackBody extends StatefulWidget {


  @override
  State<FeedBackBody> createState() => _FeedBackBodyState();
}

class _FeedBackBodyState extends State<FeedBackBody> {
  TextEditingController message = TextEditingController();
  FeedbackApiService apiFeedback = FeedbackApiService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      return Form(
        key: _formkey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text("اكتب رايك عن تطبيقنا",
                    style: TextStyle(color: Colors.white70, fontSize: 20),),
                ),
                Padding(padding: EdgeInsets.only(left: 0),
                  child: Divider(
                    color: Colors.white54,
                    height: 1,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xb3ffffff),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextFormField(
                    controller: message,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الحقل فاضي";
                      }
                      return null;
                    },
                    maxLines: 8,
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
                SizedBox(height: 10,),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        FeedbackModel feedback = FeedbackModel(
                            feedbackId: "0",
                            feedback: message.text,
                            feedbackTime: "--",
                            studentId: tr
                        );
                        if (tr!="0"){
                        var res = await apiFeedback.addFeedback(feedback);
                        if (res == "تم العملية بنجاح")
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${res}")));
                        Navigator.pop(context, MaterialPageRoute(builder: (
                            context) => Nav_bar()));
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account()));
                      }}
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                        onPrimary: Colors.black,
                        primary: Color(0xfffffffe)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("موافق", style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    }
   String? tr;
    get() async {
        tr =await prefs.getString("Student_Id")??"null";
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
}
class ads extends StatelessWidget {
   ads({super.key});
   AdsApiService apiAds= AdsApiService();
   String? adsPath="http://${localhostip.toString()}/Api_Student_m/Images/Ads/";
     @override
     Widget build(BuildContext context) {
       return  FutureBuilder<List>(
         future: apiAds.fetchAds(),
         builder: (BuildContext context,snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           if(snapshot.connectionState == ConnectionState.done) {
             if (snapshot.hasError) {
              // print(snapshot.error);
               return Center(
                 child: Text('    404  لايوجد انترنت',
                   style: TextStyle(color: Colors.red),),
               );
             }
             return CarouselSlider.builder(
               itemCount: snapshot.data!.length,
               itemBuilder:(context,index,realindex){
                 return InkWell(
                   onTap: () async {
                     await launchUrlString("${snapshot.data?[index].link}");
                     SystemChrome.latestStyle;
                   },
                     child: Image.network("$adsPath${snapshot.data![index].adsImage}",fit: BoxFit.cover,)
                 );
               },
               options: CarouselOptions(
                   disableCenter: true,
                   animateToClosest: false,
                   reverse: true,
                   autoPlay: true,
                   autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                   autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                   autoPlayInterval: const Duration(seconds: 2),
                   enlargeCenterPage: true,
                   aspectRatio: 1.5,
                   onPageChanged: (index,reason){

                   }
               ),
             );
           }
           return CircularProgressIndicator();
         },

       ) ;


     }
   }
