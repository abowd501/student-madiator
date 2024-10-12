import 'dart:async';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';
//import 'package:student_mediator/Screens/Home.dart';
import 'package:student_mediator/Screens/Vehical.dart';
import 'package:student_mediator/Services/BookingApi.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Model/Booking.dart';
import '../Model/Student.dart';
import '../Model/Vehicle.dart';
import '../Services/StudentApi.dart';
import '../Services/VehicleApi.dart';
import '../main.dart';

class Booking extends StatefulWidget {
   Booking(this.tr1);
String? tr1;
  @override
  State<Booking> createState() => _Booking(tr1);
}

class _Booking extends State<Booking> {


  String? s;
  String? bookingId;
  String? userImage="http://$localhostip/Api_Student_m/Images/Students/";
  String? vehicleImage="http://$localhostip/Api_Student_m/Images/Vehicle/";
  BookingApiService apiBooking=BookingApiService();
  VehicleApiService apiVehicle=VehicleApiService();
  StudentApiService apiStudent=StudentApiService();
  String? tr;

  List<BookingModel> seardata=[];
  _Booking(this.tr);
  get()async {
    tr = prefs.getString("Student_Id")!;
  }
  int _cont=0;
  _conBooking()async {
    List<BookingModel> d = await apiBooking.fetchBooking("1", s.toString());
    setState(() {
      _cont = d.length;
    });
  }
    Future Bo()async{
    seardata=(await  apiBooking.fetchBookingId(tr!)) as List<BookingModel>;
  }
  int myacount=0;

  @override

@override
   initState()  {
    // TODO: implement initState
    super.initState();
    get();
    Bo();
    _conBooking();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30,
          ),
          child: Container(
            color:Colors.white70,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                       FutureBuilder<List<BookingModel>>(
                           future: apiBooking.fetchBookingId(tr.toString()),
                         builder: (BuildContext context,  snapshot) {
                             if(snapshot.connectionState==ConnectionState.waiting){
                               return CircularProgressIndicator();
                             }
                             if(snapshot.connectionState==ConnectionState.done){
                               if(snapshot.hasError){
                                 return Container(
                                   height: MediaQuery.of(context).size.height*0.8,
                                   child: Center(
                                     child: Text("لا يوجد انترنت "),
                                   ),
                                 );
                               }
                               if(snapshot.data!.isEmpty){
                                 return Container(
                                   height: MediaQuery.of(context).size.height*0.8,
                                   child: Center(
                                     child: Text("لا يوجد حجز "),
                                   ),
                                 );
                               }
                               if(snapshot.data?[0].booking=="1"){
                                 s=snapshot.data?[0].vehicleId;
                                 bookingId=snapshot.data![0].bookingId;
                                 return Column(
                                   children: [
                                     SizedBox(height: 5,),
                                     FutureBuilder<List<VehicleModel>>(
                                       future: apiVehicle.fetchVehicle(),
                                       builder: (BuildContext context, AsyncSnapshot<List<VehicleModel>> snapshot2) {
                                         var ss=snapshot2.data?.where((element) => element.vehicleId==s).first;
                                         String? studentPhone="0";
                                         if(snapshot.connectionState==ConnectionState.waiting){return CircularProgressIndicator();}
                                         if(snapshot2.connectionState==ConnectionState.done){
                                           if(snapshot.hasError){
                                             return Container(
                                               height: MediaQuery.of(context).size.height*0.8,
                                               child: Center(
                                                 child: Text("لا يوجد انترنت "),
                                               ),
                                             );
                                           }
                                           if(snapshot2.hasData){
                                             return Container(
                                               padding: EdgeInsets.all(5),
                                               decoration: BoxDecoration(
                                                 //     color: Colors.white70,
                                                   borderRadius: BorderRadius.circular(20)
                                               ),
                                               child: Column(
                                                 children: [
                                                   FutureBuilder<List<StudentModel>>(
                                                     future: apiStudent.fetchStudentId(ss!.studentId.toString()),
                                                     builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot1) {
                                                       var ss=snapshot1.data?.first;//.where((element) => element.studentId==snapshot2.data?.last.studentId).first;
                                                       if(snapshot1.connectionState==ConnectionState.waiting){return CircularProgressIndicator();}
                                                       if(snapshot1.connectionState==ConnectionState.done){
                                                         if(snapshot.hasError){
                                                           return Center();
                                                         }
                                                         studentPhone=ss?.phone;
                                                         return ListTile(
                                                           title: Text(
                                                             "${ss?.name}",
                                                             style: TextStyle(
                                                               fontWeight: FontWeight.bold,
                                                             ),
                                                           ),
                                                           subtitle: Text("${ss?.email}"),
                                                           leading: CircleAvatar(
                                                             radius: 25,
                                                             backgroundImage: NetworkImage("$userImage${ss?.image}"),
                                                           ),
                                                         );
                                                       }
                                                       return Center();
                                                     },
                                                   ),
                                                   Column(
                                                     children: [
                                                       CarouselSlider.builder(
                                                         itemCount: ss.images?.split(',').length??1,
                                                         itemBuilder: (context, index,
                                                             realindex) {
                                                           var im = ss.images?.split(
                                                               ",")[index]
                                                               .split(" ")
                                                               .last;
                                                           return im
                                                               .toString().isImageFileName ? Image
                                                               .network("$vehicleImage${ss.images?.split(",")[index].split(" ").last??"404.png"}", height: 200,
                                                             fit: BoxFit.cover,) : Container(
                                                             height: 200,);
                                                         },
                                                         options: CarouselOptions(
                                                             disableCenter: true,
                                                             animateToClosest: true,
                                                             reverse: true,
                                                             aspectRatio: 1.2,
                                                             viewportFraction: 1.0,
                                                             onPageChanged: (index, reason) {
                                                               // setState((){
                                                               myacount = index;
                                                               //  });
                                                             }
                                                         ),
                                                       ),
                                                       SizedBox(height: 10,),
                                                       Padding(
                                                         padding: const EdgeInsets.only(bottom: 8.0),
                                                         child: AnimatedSmoothIndicator(activeIndex: myacount,
                                                           count: ss.images?.split(',').length??1,
                                                           effect: const WormEffect(
                                                             dotColor: Colors.black,
                                                             dotHeight: 8,
                                                             dotWidth: 8,
                                                           ),

                                                         ),
                                                       ),
                                                     ],
                                                   ) ,
                                                   Column(
                                                     children: [
                                                       Container(
                                                         width: MediaQuery.of(context).size.width*0.6,
                                                         decoration: BoxDecoration(
                                                             color: Colors.white,
                                                             borderRadius: BorderRadius.circular(20)
                                                         ),
                                                         child: ListTile(
                                                           title:Text("نوع المركبه",style: TextStyle(fontWeight: FontWeight.bold),),
                                                           trailing:Text("${ss.type}"),
                                                           leading: Icon(CupertinoIcons.car_detailed,color: Colors.brown,),
                                                         ),
                                                       ),
                                                       SizedBox(height: 10,),
                                                       Container(
                                                         width: MediaQuery.of(context).size.width*0.7,
                                                         decoration: BoxDecoration(
                                                             color: Colors.white,
                                                             borderRadius: BorderRadius.circular(20)
                                                         ),
                                                         child: ListTile(
                                                           title:Text("الكليه",style: TextStyle(fontWeight: FontWeight.bold),),
                                                           trailing:Text("الحاسبات"),
                                                           leading: Icon(CupertinoIcons.collections_solid,color: Colors.brown,),
                                                         ),
                                                       ),
                                                       SizedBox(height: 10,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                         children: [
                                                           Container(
                                                             width: MediaQuery.of(context).size.width*0.4,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child:ListTile(
                                                               title:Text(" الانطلاقه",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                               subtitle:Text("${ss.stringPoint}"),
                                                               leading: Icon(CupertinoIcons.location_solid,color: Colors.brown,),
                                                             ),
                                                           ),
                                                           Container(
                                                             width: MediaQuery.of(context).size.width*0.4,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child:ListTile(
                                                               title:Text(" الوجهه",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                               subtitle:Text("${ss.distnitionPoint}"),
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
                                                             width: MediaQuery.of(context).size.width*0.4,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child:ListTile(
                                                               subtitle:Text("وقت الذهاب"),
                                                               title:Text("${ss.arrivalTime}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                               leading: Icon(CupertinoIcons.clock_fill,color: Colors.brown,),
                                                             ),
                                                           ),
                                                           Container(
                                                             width: MediaQuery.of(context).size.width*0.4,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child:ListTile(
                                                               subtitle:Text("وقت العوده"),
                                                               title:Text("${ss.returnTime}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                               leading: Icon(CupertinoIcons.clock_fill,color: Colors.brown,),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       SizedBox(height: 10,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                         children: [
                                                           Container(
                                                             width: MediaQuery.of(context).size.width*0.4,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child:ListTile(
                                                               subtitle:Text("عدد الركاب"),
                                                               title:Text("$_cont",style: TextStyle(fontWeight: FontWeight.bold),),
                                                               leading: Icon(CupertinoIcons.person_2_alt,color: Colors.brown,),
                                                             ),
                                                           ),
                                                           Container(
                                                             width: MediaQuery.of(context).size.width*0.4,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child:ListTile(
                                                               subtitle:Text("عدد المقاعد"),
                                                               title:Text("${ss.numSeats}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                               leading: Icon(CupertinoIcons.bed_double_fill,color: Colors.brown,),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       SizedBox(height: 10,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                         children: [
                                                           Container(
                                                             width: MediaQuery.of(context).size.width*0.55,
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(20)
                                                             ),
                                                             child: ListTile(
                                                               title:Text("حاله المركبه",style: TextStyle(fontWeight: FontWeight.bold),),
                                                               trailing:Icon(Icons.ac_unit,color: Colors.brown,),
                                                               subtitle:ss.stute=="0"? Text("غير مكتملة"):Text(" مكتملة"),
                                                               leading: Icon(CupertinoIcons.car_detailed,color: Colors.brown,),
                                                             ),
                                                           ),

                                                         ],
                                                       ),
                                                       SizedBox(height: 20,),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                         children: [
                                                           SizedBox(
                                                             height: 55,
                                                             width: 190,
                                                             child: ElevatedButton(
                                                               onPressed: (){
                                                                 //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account()));
                                                               },
                                                               style: ElevatedButton.styleFrom(
                                                                 side: BorderSide.none,
                                                                 shape: const StadiumBorder(),
                                                                 onPrimary: Colors.black,
                                                                 primary: Colors.brown,
                                                               ),
                                                               child: InkWell(
                                                                 onTap: ()async{
                                                                   if(tr!="null"){
                                                                     var res=await apiBooking.deleteBooking(bookingId!);
                                                                   //  Navigator.push(context,MaterialPageRoute(builder:  (con)=> Nav_bar()));

                                                                   }
                                                                 },
                                                                 child: Padding(
                                                                   padding: const EdgeInsets.all(8.0),
                                                                   child: Text("الغاء حجز",style: TextStyle(
                                                                     fontSize: 20,
                                                                     color: Colors.white,
                                                                   ),),
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             height: 55,
                                                             width: 140,
                                                             child: ElevatedButton(
                                                               onPressed: () async {
                                                                 await launchUrlString("tel:$studentPhone");
                                                                 //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account()));
                                                               },
                                                               style: ElevatedButton.styleFrom(
                                                                 side: BorderSide.none,
                                                                 shape: const StadiumBorder(),
                                                                 onPrimary: Colors.black,
                                                                 primary: Colors.brown,
                                                               ),
                                                               child: Padding(
                                                                 padding: const EdgeInsets.all(8.0),
                                                                 child: Text(" التواصل  ",style: TextStyle(
                                                                   fontSize: 20,
                                                                   color: Colors.white,
                                                                 ),),
                                                               ),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       SizedBox(height: 10,),
                                                     ],
                                                   ),
                                                 ],
                                               ),
                                             );
                                           }
                                         }
                                         return Center();
                                       },

                                     ),
                                   ],
                                 );
                               }
                               else{
                                 return Container(
                                   margin: EdgeInsets.all( 10),
                                   padding: EdgeInsets.all( 5),
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
                                         SizedBox(height: 50,),
                                         FutureBuilder<List<VehicleModel>>(
                                           future: apiVehicle.fetchVehicle(),
                                           builder: (BuildContext context, AsyncSnapshot<List<VehicleModel>> snapshot3) {
                                             var ss=snapshot3.data?.where((element) => element.vehicleId==snapshot.data![0].vehicleId).first;
                                             if(snapshot3.connectionState==ConnectionState.waiting){return CircularProgressIndicator();}
                                             if(snapshot3.connectionState==ConnectionState.done){
                                               if(snapshot.hasError){
                                                 return Container(
                                                   height: MediaQuery.of(context).size.height*0.8,
                                                   child: Center(
                                                     child: Text("لا يوجد انترنت "),
                                                   ),
                                                 );
                                               }
                                               if(snapshot3.hasData){
                                                 return Container(
                                                   padding: EdgeInsets.all(5),
                                                   decoration: BoxDecoration(
                                                     //     color: Colors.white70,
                                                       borderRadius: BorderRadius.circular(20)
                                                   ),
                                                   child: Column(
                                                     children: [
                                                       Column(
                                                         children: [
                                                           CarouselSlider.builder(
                                                             itemCount: ss?.images?.split(',').length??1,
                                                             itemBuilder: (context, index,
                                                                 realindex) {
                                                               var im = ss?.images?.split(
                                                                   ",")[index]
                                                                   .split(" ")
                                                                   .last;
                                                               return im
                                                                   .toString().isImageFileName ? Image
                                                                   .network("$vehicleImage${ss?.images?.split(",")[index].split(" ").last??"404.png"}", height: 200,
                                                                 fit: BoxFit.cover,) : Container(
                                                                 height: 200,);
                                                             },
                                                             options: CarouselOptions(
                                                                 disableCenter: true,
                                                                 animateToClosest: true,
                                                                 reverse: true,
                                                                 aspectRatio: 1.2,
                                                                 viewportFraction: 1.0,
                                                                 onPageChanged: (index, reason) {
                                                                   // setState((){
                                                                   myacount = index;
                                                                   //  });
                                                                 }
                                                             ),
                                                           ),
                                                           SizedBox(height: 10,),
                                                         ],
                                                       ) ,
                                                       Column(
                                                         children: [
                                                           SizedBox(height: 10,),
                                                           Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                             children: [
                                                               Container(
                                                                 width: MediaQuery.of(context).size.width*0.4,
                                                                 decoration: BoxDecoration(
                                                                     color: Colors.white,
                                                                     borderRadius: BorderRadius.circular(20)
                                                                 ),
                                                                 child:ListTile(
                                                                   subtitle:Text("عدد الركاب"),
                                                                   title:Text("$_cont",style: TextStyle(fontWeight: FontWeight.bold),),
                                                                   leading: Icon(CupertinoIcons.person_2_alt,color: Colors.brown,),
                                                                 ),
                                                               ),
                                                               Container(
                                                                 width: MediaQuery.of(context).size.width*0.4,
                                                                 decoration: BoxDecoration(
                                                                     color: Colors.white,
                                                                     borderRadius: BorderRadius.circular(20)
                                                                 ),
                                                                 child:ListTile(
                                                                   subtitle:Text("عدد المقاعد"),
                                                                   title:Text("${ss?.numSeats}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                                   leading: Icon(CupertinoIcons.bed_double_fill,color: Colors.brown,),
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 10,),
                                                           Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                             children: [
                                                               Container(
                                                                 width: MediaQuery.of(context).size.width*0.55,
                                                                 decoration: BoxDecoration(
                                                                     color: Colors.white,
                                                                     borderRadius: BorderRadius.circular(20)
                                                                 ),
                                                                 child: ListTile(
                                                                   title:Text("حاله المركبه",style: TextStyle(fontWeight: FontWeight.bold),),
                                                                   trailing:Icon(Icons.ac_unit,color: Colors.brown,),
                                                                   subtitle:ss?.stute=="0"? Text("غير مكتملة"):Text(" مكتملة"),
                                                                   leading: Icon(CupertinoIcons.car_detailed,color: Colors.brown,),
                                                                 ),
                                                               ),

                                                             ],
                                                           ),

                                                         ],
                                                       ),
                                                     ],
                                                   ),
                                                 );
                                               }
                                             }
                                             return Center();
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
                                                 "${snapshot.data![0].bookTime?.split(' ').last}",
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
                                                   "${snapshot.data![0].bookTime?.split(" ")[1]}",
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
                                               Text( "${snapshot.data![0].booking}قيد الانتظار...",
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
                                                 var dd=await apiBooking.deleteBooking(snapshot.data![0].bookingId.toString());
                                                 if(dd){
                                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم الخذف ")));
                                                   setState(() {
                                                     _cont=0;
                                                   });
                                                 }
                                                 if(dd==false){
                                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("لم بتم الخذف ")));
                                                   Navigator.pop(context);
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
                                                   child: Text("الغاء الطلب",
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
                               }


                             }
                             if(snapshot.connectionState==ConnectionState.none){
                               return Center(
                                 child: Text("Page Null"),
                               );
                             }
                             return Center(
                               child: Text("Page Null2"),
                             );
                         },
                       ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),


      ),
    );
  }

}



Future<Object?> Rating1(BuildContext context,
    {required ValueChanged onCLosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(-1, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.2, horizontal: MediaQuery.of(context).size.width*0.1),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Color(0xd5bb8a52),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RatingBody(),
      ),
    ),
  ).then(onCLosed);
}

class RatingBody extends StatefulWidget {
  const RatingBody({super.key});

  @override
  State<RatingBody> createState() => _RatingBodyState();
}

class _RatingBodyState extends State< RatingBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: SingleChildScrollView(
       child: Column(
         children: [
           Center(
             child: Text("التقييم",style: TextStyle(color: Colors.white70,fontSize: 20),),
           ),
           Padding(padding: EdgeInsets.only(left: 0),
             child: Divider(
               color: Colors.white54,
               height: 1,
             ),
           ),
           Center(
             child: Text("حدد النجوم",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 20
               ),
             ),
           ),
           Center(
             child: RatingBar.builder(
               initialRating: 2.5,
               minRating: 1,
               direction: Axis.horizontal,
               allowHalfRating: true,
               itemCount: 5,
               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
               itemBuilder: (context, _) => Icon(
                 Icons.star,
                 color: Colors.amber,
               ),
               onRatingUpdate: (rating) {
                 print(rating);
               },
             ),
           ),
           SizedBox(height: 20,),
           Center(
             child: Text("ماهو رايك عن صاحب المركبه",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 18
               ),
             ),
           ),
           SizedBox(height: 10,),
           Container(
             decoration: BoxDecoration(
                 color: Color(0xb3ffffff) ,
                 borderRadius: BorderRadius.circular(20)
             ),
             child: TextField(
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
               onPressed: (){
                 //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account()));
               },
               style: ElevatedButton.styleFrom(
                   side: BorderSide.none,
                   shape: const StadiumBorder(),
                   onPrimary: Colors.black,
                   primary: Color(0xfffffffe)
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("موافق",style: TextStyle(
                     fontSize: 18,
                     color: Colors.black
                 ),),
               ),
             ),
           ),

         ],
       ),
     ),
    );
  }
}
