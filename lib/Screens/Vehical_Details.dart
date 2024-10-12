import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_mediator/Model/Booking.dart';
import 'package:student_mediator/Model/Student.dart';
import 'package:student_mediator/Model/Vehicle.dart';
import 'package:student_mediator/Screens/Vehical.dart';
import 'package:student_mediator/Services/BookingApi.dart';
import 'package:student_mediator/Services/StudentApi.dart';
import '../Services/VehicleApi.dart';
import '../main.dart';

class Vehical_Details extends StatefulWidget {
  String? s ;
  String? id ;
  Vehical_Details(this.s,this.id);
  @override
  State<Vehical_Details> createState() => _Vehical_Details(s,id);
}

class _Vehical_Details extends State<Vehical_Details> {

  int myacount=0;
String? s;
String? id;
  String? userImage="http://$localhostip/Api_Student_m/Images/Students/";
  String? vehicleImage="http://$localhostip/Api_Student_m/Images/Vehicle/";
  VehicleApiService apiVehicle=VehicleApiService();
  StudentApiService apiStudent=StudentApiService();
  BookingApiService apiBooking=BookingApiService();
  _Vehical_Details(this.s,this.id);
  String? tr;
  int _cont=0;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _conBooking();
  }
  _conBooking()async{
    List<BookingModel> d=await apiBooking.fetchBooking("1",s.toString());
    setState(() {
      _cont= d.length;
    });

  }
  @override
  Widget build(BuildContext context) {
    get();
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
              color:Colors.brown.shade50,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [

                        FutureBuilder<List<StudentModel>>(
                          future: apiStudent.fetchStudent(),
                          builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot) {
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return CircularProgressIndicator();
                            }
                            //var ss=snapshot.data?.first;
                            var ss=snapshot.data!.where((element) => element.studentId==id).first;
                            return ListTile(
                              title: Text(
                                "${ss?.name}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("${ss?.email}"),
                              trailing:  TextButton(
                                  onPressed: (){
                                Navigator.pop(context, MaterialPageRoute(builder: (context)=>Vehical()));
                              },
                                  child:Icon(CupertinoIcons.arrow_left,color: Colors.black,)),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("$userImage${ss?.image}"),
                              ),
                            );
                          },
                        ),
                        Column(
                          children: [
                          /*  CarouselSlider.builder(
                              itemCount: Vehical1.length,
                              itemBuilder:(context,index,realindex){
                                return Image.asset(Vehical1[index],height: 200,fit: BoxFit.cover,);
                              },
                              options: CarouselOptions(
                                  disableCenter: true,
                                  animateToClosest: false,
                                  reverse: true,
                                  //autoPlay: true,
                                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                                  autoPlayInterval: const Duration(seconds: 2),
                                  enlargeCenterPage: true,
                                  aspectRatio: 1.2,
                                  viewportFraction: 1.0,
                                  onPageChanged: (index,reason){
                                    setState((){
                                      myacount=index;
                                    });
                                  }
                              ),
                            ),*/

                          ],
                        ) ,
                        SizedBox(height: 5,),
                        FutureBuilder<List<VehicleModel>>(
                          future: apiVehicle.fetchVehicle(),
                          builder: (BuildContext context, AsyncSnapshot<List<VehicleModel>> snapshot) {
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return CircularProgressIndicator();
                            }
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return CircularProgressIndicator();
                            }
                            if(snapshot.connectionState==ConnectionState.done) {
                              var ss = snapshot.data!.where((element) => element.vehicleId==s).first;
                              if(snapshot.hasError){return Text(" error");}
                              if(snapshot.hasData){
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
                                            itemCount: ss.images?.split(',').length??1,
                                            itemBuilder: (context, index,
                                                realindex) {
                                              var im = ss.images?.split(
                                                  ",")[index]
                                                  .split(" ")
                                                  .last;
                                              return im
                                                  .toString()
                                                  .isImageFileName ? Image
                                                  .network("$vehicleImage${ss.images?.split(",")[index].split(" ").last??"404.png"}", height: 200,
                                                fit: BoxFit.cover,) : Container(
                                                height: 200,);
                                            },
                                            options: CarouselOptions(
                                                disableCenter: true,
                                                animateToClosest: true,
                                                reverse: true,
                                                //  autoPlay: true,
                                                // autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                                // autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                                                // autoPlayInterval: const Duration(seconds: 2),
                                                //enlargeCenterPage: true,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: AnimatedSmoothIndicator(
                                              activeIndex: 1,
                                              count: ss.images?.split(',').length??1,
                                              effect: const WormEffect(
                                                dotColor: Colors.black,
                                                dotHeight: 8,
                                                dotWidth: 8,
                                              ),

                                            ),
                                          ),
                                          SizedBox(),
                                          SizedBox(),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(20)
                                            ),
                                            child: ListTile(
                                              title: Text("نوع المركبه",
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),),
                                              trailing: Text("${ss.type}"),
                                              leading: Icon(
                                                CupertinoIcons.car_detailed,
                                                color: Colors.brown,),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.7,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(20)
                                            ),
                                            child: ListTile(
                                              title: Text("الكليه",
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),),
                                              trailing: Text("الحاسبات"),
                                              leading: Icon(
                                                CupertinoIcons.collections_solid,
                                                color: Colors.brown,),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  title: Text(" الانطلاقه",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 14),),
                                                  subtitle: Text(
                                                      "${ss.stringPoint}"),
                                                  leading: Icon(
                                                    CupertinoIcons.location_solid,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  title: Text(" الوجهه",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 14),),
                                                  subtitle: Text(
                                                      "${ss.distnitionPoint}"),
                                                  leading: Icon(
                                                    CupertinoIcons.location_solid,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  subtitle: Text("وقت الذهاب"),
                                                  title: Text("${ss.arrivalTime}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 14),),
                                                  leading: Icon(
                                                    CupertinoIcons.clock_fill,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  subtitle: Text("وقت العوده"),
                                                  title: Text("${ss.returnTime}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 14),),
                                                  leading: Icon(
                                                    CupertinoIcons.clock_fill,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  subtitle: Text("عدد الركاب"),
                                                  title: Text("${_cont.toString()}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold),),
                                                  leading: Icon(
                                                    CupertinoIcons.person_2_alt,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  subtitle: Text("عدد المقاعد"),
                                                  title: Text("${ss.numSeats}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold),),
                                                  leading: Icon(CupertinoIcons
                                                      .bed_double_fill,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(20)
                                                ),
                                                child: ListTile(
                                                  title: Text("حاله المركبه",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold),),
                                                  trailing: Icon(Icons.ac_unit,
                                                    color: Colors.brown,),
                                                  subtitle: ss.stute == "0"
                                                      ? Text("غير مكتملة")
                                                      : Text(" مكتملة"),
                                                  leading: Icon(
                                                    CupertinoIcons.car_detailed,
                                                    color: Colors.brown,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              SizedBox(
                                                height: 55,
                                                width: 190,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    side: BorderSide.none,
                                                    shape: const StadiumBorder(),
                                                    onPrimary: Colors.black,
                                                    primary: Colors.brown,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      showDialog(context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                              icon: Icon(Icons
                                                                  .border_color_outlined,
                                                                color: Colors
                                                                    .brown,),
                                                              title: Text(
                                                                "تأكيد الجحز",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              content: Text(
                                                                "هل تريد الحجز الان",
                                                                style: TextStyle(
                                                                    fontSize: 15),
                                                              ),
                                                              actions: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    SizedBox(
                                                                      child: ElevatedButton(
                                                                        onPressed: () async {
                                                                          Navigator
                                                                              .pop(
                                                                              context);
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
                                                                          BookingModel modelbook = BookingModel(
                                                                              bookingId: "0",
                                                                              booking: "0",
                                                                              bookTime: "0",
                                                                              studentId: tr,
                                                                              vehicleId: ss
                                                                                  .vehicleId);
                                                                          var res = await apiBooking
                                                                              .addBooking(
                                                                              modelbook);
                                                                          if (res) {
                                                                            ScaffoldMessenger
                                                                                .of(
                                                                                context)
                                                                                .showSnackBar(
                                                                                SnackBar(
                                                                                    content: Text(
                                                                                        "تم الحجز ")));
                                                                            Navigator
                                                                                .pop(
                                                                                context);
                                                                          } else {
                                                                            Navigator
                                                                                .pop(
                                                                                context);
                                                                            ScaffoldMessenger
                                                                                .of(
                                                                                context)
                                                                                .showSnackBar(
                                                                                SnackBar(
                                                                                    content: Text(
                                                                                        " انت بالفعل لدبك حجز ")));
                                                                          }
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                            side: BorderSide
                                                                                .none,
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
                                                                            "تأكيد",
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
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                        "حجز", style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),),
                                                    ),
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
                    ),
                  ),
                ),
              ),
            ),
          ),


        ),
    );
  }
    get()async{
      SharedPreferences prefs=await SharedPreferences.getInstance() ;
        tr= prefs.getString("Student_Id")??"nulll";

}}



/// feedback for vehicle owner





