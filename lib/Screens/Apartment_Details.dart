
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

import 'package:android_intent_plus/android_intent.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_mediator/Model/Apartment.dart';
import 'package:student_mediator/Screens/Apartment.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Services/ApartmentApi.dart';
import '../main.dart';

class Apartment_Details extends StatefulWidget {
  final String s;
  Apartment_Details( this.s );

  @override
  State<Apartment_Details> createState() => _Apartment_DetailsState(s);
}

class _Apartment_DetailsState extends State<Apartment_Details> {
  String? userImage="http://$localhostip/Api_Student_m/Images/Students/";
  String? apartmentImage="http://$localhostip/Api_Student_m/Images/apartment/";

  int myacount=0;
  final String s;
  ApartmentApiService apiAprtment=ApartmentApiService();
  _Apartment_DetailsState(this.s);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(

        image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),fit: BoxFit.cover),
          color: Colors.white70,  ),
        child:  BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30,
          ),
          child: SafeArea(
            child: Container(
            color: Colors.brown.shade50,
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("  تفصيل الشقه $s" ,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),
                        TextButton(onPressed: (){
                          Navigator.pop(context, MaterialPageRoute(builder: (context)=>Apartment()));
                        },
                            child:Icon(CupertinoIcons.arrow_left,color: Colors.black,))
                      ],
                      ),
                    /*  Container(
                       // padding: EdgeInsets.symmetric(vertical: 20),
                       // width: double.infinity,
                     //   color: Colors.white70,
                        child: Column(
                          children: [

                            SizedBox(height: 10,),
                            AnimatedSmoothIndicator(activeIndex: myacount,
                              count: ss.length,
                              effect: const WormEffect(
                                dotColor: Colors.black,
                                dotHeight: 8,
                                dotWidth: 8,
                              ),
                            ),
                          ],
                        ),
                      ) ,*/
                     FutureBuilder<List<ApartmentModel>>(
                       future: apiAprtment.fetchApartment() ,
                        builder: (BuildContext context, AsyncSnapshot<List<ApartmentModel>> snapshot) {
                          var ss=snapshot.data?.where((element) => element.apartmentId==s).first;
                          if(snapshot.connectionState==ConnectionState.done) {
                           // var ss = snapshot.data!.where((element) => element.vehicleId==s).first;
                            if(snapshot.hasError){return Text(" error");}
                            if(snapshot.hasData){
                              return Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  //        color: Colors.white70,
                                  // borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  children: [
                                    CarouselSlider.builder(
                                      itemCount: ss?.images?.split(',').length??1,
                                      itemBuilder:(context,index,realindex){
                                        return Image.network("$apartmentImage${ss?.images?.split(",")[index].split(" ").last??"404.png"}",height: 200,fit: BoxFit.cover,);
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
                                          onPageChanged: (index,reason){
                                            // setState((){
                                            myacount=index;
                                            //  });
                                          }
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: ()async{
                                                // if(await canLaunch("tel:772240564")){
                                                await launchUrlString("tel:772240564");

                                                //launchUrl(Uri.parse("tel:772240564"));
                                                //  launchUrlString("tel:772240564");

                                                //  AndroidIntent phone=AndroidIntent(action: 'action_dial',data:'tel://+667772240564',);
                                                //  phone.launch();
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width*0.35,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.brown,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child:Row(
                                                  children: [
                                                    Icon(CupertinoIcons.phone_circle_fill,color: Colors.white,),
                                                    Text(" تواصل للحجز",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.4,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child:ListTile(
                                                title:Text(" السعر",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                                subtitle:Text("${ss?.price}"),
                                                leading: Icon(CupertinoIcons.money_dollar_circle_fill,color: Colors.brown,),
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
                                                title:Text("الموقع",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle:Text("${ss?.location}",style: TextStyle(fontWeight: FontWeight.bold),),
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
                                                title:Text("الدور",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle:Text("${ss?.floor}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                leading: Icon(Icons.home_work,color: Colors.brown,),
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
                                                title:Text("حمامات",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle:Text("${ss?.numBith}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                leading: Icon(Icons.bathtub,color: Colors.brown,),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.4,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child:ListTile(
                                                title:Text("الغرف",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle:Text("${ss?.numRoom}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                leading: Icon(Icons.meeting_room,color: Colors.brown,),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.8,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: ListTile(
                                            title:Center(child: Text("الوصف",style: TextStyle(fontWeight: FontWeight.bold),)),
                                            // trailing:Icon(Icons.ac_unit),
                                            subtitle:Text("${ss?.discription}"),
                                            // leading: Icon(CupertinoIcons.car_detailed),
                                          ),
                                        ),
                                        SizedBox(height: 20,),

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


    ));
  }
}

