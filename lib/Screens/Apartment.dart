
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Apartment.dart';
import 'package:student_mediator/Screens/Apartment_Details.dart';

import '../Services/ApartmentApi.dart';
import '../main.dart';
import 'Settings.dart';

class Apartment extends StatefulWidget {
  const Apartment({super.key});

  @override
  State<Apartment> createState() => _ApartmentState();
}

class _ApartmentState extends State<Apartment> {
  ApartmentApiService apiAprtment=ApartmentApiService();
  TextEditingController search =TextEditingController();
   List<ApartmentModel> seardata=[];
  Future Apart()async{
    seardata=await  apiAprtment.fetchApartment();
  }
  String? apartmentImage="http://$localhostip/Api_Student_m/Images/apartment/";
  void initState() {
    super.initState();
    Apart();

  }
  @override
  Widget build(BuildContext context) {
    double _size=MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-1.png"), fit: BoxFit.cover),
          ),
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                     Container(
                          color: Colors.white12,
                          child: Column(
                            children: [
                             SizedBox(height:10,),
                              Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(" الشقق" ,style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),),
                                 // SizedBox()
                                ],
                              ),

                            //  SizedBox(height: 5,)
                            ],
                          ),
                        ),
                       //search
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextField(
                          onChanged: (val) async {
                             if(val.isNotEmpty) {
                               var ls = await seardata.where((element) =>
                               element.price!.contains(val.toString()) ||
                                   element.location!.contains(val.toString()) ||
                                   element.numRoom!.contains(val.toString()))
                                   .toList();
                               setState(() {
                                 seardata = ls;
                               });
                             }else{
                               Apart();
                             }
                          },
                          controller:search ,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                              label: Text("البحث",style: TextStyle(fontSize: 18),),
                              suffixIcon: InkWell(
                                onTap: () async {
                                 await Filter1(context, onCLosed: (_) {setState(() {});},);
                                  SharedPreferences prefs=await SharedPreferences.getInstance();
                                 var price=await prefs.getString("fprice");
                                  var location=await prefs.getString("flocation");
                                  var rooms=await prefs.getString("frooms");
                                  var bath=await prefs.getString("fbath");


                                 String _price=price!.split(',').first.split('.').first.toString();
                                    var ls = await seardata.where((element) =>
                                        element.price!.contains(_price) &&
                                        element.location!.contains(location.toString()) &&
                                        element.numBith!.contains(bath.toString()) &&
                                        element.numRoom!.contains(rooms.toString()))
                                        .toList();
                                    setState(() {
                                      seardata = ls;
                                    });

                                },
                                child: Icon(CupertinoIcons.arrow_up_arrow_down_circle,color: Colors.brown,size: 40,),
                              ),
                              prefixIcon: InkWell(
                                onTap: (){},
                                child: Icon(CupertinoIcons.search_circle_fill,color: Colors.brown,size: 40,),
                              )
                          ),
                        ),
                      ),
                     // SizedBox(height: 15,),
                      //body
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: FutureBuilder<List<ApartmentModel>>(
                            future: apiAprtment.fetchApartment(),
                            builder: (context, snapshot) {
                             // var seardata=snapshot.data;
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if(snapshot.connectionState == ConnectionState.done){
                                if (snapshot.hasError) {
                                 // print(snapshot.error);
                                  return Container(
                                    height: 610,
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
                                return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,
                                        crossAxisSpacing: 5.0,mainAxisSpacing: 5.0),
                                    itemCount: seardata?.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, index) {
                                      int id=int.parse(snapshot.data![index].apartmentId.toString());
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              Apartment_Details(seardata[index].apartmentId.toString())));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(2),
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            boxShadow: [BoxShadow(
                                                blurRadius: 5,
                                                color: Color(0xa5a1a0a0),
                                                spreadRadius: 1

                                            )
                                            ],

                                          ),
                                          child: Column(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context).size.width * 0.32,
                                                decoration: BoxDecoration(
                                                  color: Colors.black38,
                                                  borderRadius: BorderRadius.circular(20),
                                                  image:DecorationImage(image: NetworkImage("$apartmentImage${seardata![index].images?.split(",").first.split(" ").last}"),fit: BoxFit.cover),
                                                ),

                                              
                                              ),
                                              Row(
                                                textDirection: TextDirection.rtl,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Text(
                                                    "${seardata[index].location}", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),),
                                                  Text("${seardata[index].price}", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Icon(Icons.bathtub_rounded,
                                                    color: Colors.brown,
                                                    size: 20,),
                                                  Text('${seardata![index].numBith}'),
                                                  Icon(Icons.room_preferences,
                                                    color:  Colors.brown,
                                                    size: 20,),
                                                  Text('${seardata[index].numRoom}'),
                                                  Icon(
                                                    Icons.account_balance,
                                                    color: Colors.brown,
                                                    size: 20,),
                                                  Text('${seardata![index].floor}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                      //----------------------------------------------
                    ],
                  );
                }
              ),
            ),
          ) ,
          // width: double.infinity,

        ),
      ),
    );

    }
  }


