import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Vehicle.dart';
import 'package:student_mediator/Model/Vehicle_imsge.dart';
import 'package:student_mediator/Screens/Edit_Vehical.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';
import 'package:student_mediator/Screens/Profile.dart';
import 'package:student_mediator/Services/BookingApi.dart';
import 'package:student_mediator/Services/VehicleApi.dart';
import 'package:student_mediator/Services/VehicleImageApi.dart';

import '../Model/Booking.dart';
import '../main.dart';

class Vehical_Profile extends StatefulWidget {

  @override
  State<Vehical_Profile> createState() => _Vehical_Profile();
}

class _Vehical_Profile extends State<Vehical_Profile> {

   String? tr;
  VehicleApiService apiVehicle=VehicleApiService();
  VehicleImsgeApiService apiImage =VehicleImsgeApiService();
  BookingApiService apiBooking =BookingApiService();
  String? vehicleImage="http://$localhostip/Api_Student_m/Images/Vehicle/";
   int _cont=0;
   ImagePicker imagePicker=ImagePicker();
   List<XFile> pickerImage=[];
   Future<void> pickerGallery()async{
     try{
       var image=await imagePicker.pickMultiImage();
       if(image!=null){
         setState(() {
           pickerImage=image;
           print(image);
         });
       }
     }catch(error){
       print("good$error");
     }
   }
   _conBooking()async {
     List<BookingModel> d = await apiBooking.fetchBooking("1", tr.toString());
     setState(() {
       _cont = d.length;
     });
   }
     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tr=prefs.getString("Vehicle_Id");
    _conBooking();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      SafeArea(
                        child: Container(
                          color: Colors.white60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text("ملف المركبه",style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                              IconButton(
                                onPressed: (){ Navigator.pop(context, MaterialPageRoute(builder: (context)=>Profile()));},
                                icon:Icon(Icons.arrow_circle_left,size: 35,color: Colors.black,),
                              ),

                            ],
                          ),
                        ),
                      ),
                 //  val==false?
                  // wit(),
                  //  const CircularProgressIndicator():
                      FutureBuilder<List<Vehicle_ImsgeModel>>(
                        future: apiImage.fetchVehicleImsgeId(tr.toString()),
                        builder: (BuildContext context,  snapshot) {
                          var ss=snapshot.data;
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }
                          if(snapshot.connectionState==ConnectionState.done){
                            if(snapshot.hasError){
                              return Text("لايوجد انترنت");
                            }

                            if(snapshot.hasData){
                              return Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        //  borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            color: Colors.black38,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data?.length??1,
                                              itemBuilder: (BuildContext context, int index) {
                                               // print(ss?[0].image);
                                                return   Stack(
                                                  children: [
                                                    Image.network("$vehicleImage${ss?[index].image??"404.png"}"),
                                                    InkWell(
                                                      onTap: () async {
                                                        var res =await apiImage.deleteImage(snapshot.data![index].imageId);
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                                        setState(() {});
                                                      },
                                                      child: Icon(Icons.dangerous),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -1,
                                            right: -1,
                                            child:IconButton(
                                              onPressed: () async {
                                                await pickerGallery();
                                                print(pickerImage);
                                                if(pickerImage.isNotEmpty){
                                                  var res=await apiImage.postImage(tr.toString(), pickerImage);
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                                  setState(() {});
                                                }

                                              },
                                              icon:Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.brown,
                                                      borderRadius: BorderRadius.circular(100)
                                                  ),
                                                  child: Icon(Icons.download_rounded,color: Colors.white,)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //      SizedBox(height: 20,),

                                ],
                              );
                            }

                          }
                         return Center();
                        },
                      ),
                     // val==false?
                    //  CircularProgressIndicator():
                      FutureBuilder<List<VehicleModel>>(
                        future: apiVehicle.fetchVehicle(),
                        builder: (BuildContext context, AsyncSnapshot<List<VehicleModel>> snapshot) {
                          var ss = snapshot.data?.where((element) => element.vehicleId==tr).first;
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }
                          if(snapshot.connectionState==ConnectionState.done){
                            if(snapshot.hasError){
                              return Text("لايوجد انترنت");
                            }if(snapshot.data!.isEmpty){
                              return Text("لاتوجد بيانات");
                            }
                            if(snapshot.hasData){
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  // borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.7,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: ListTile(
                                        title:Text("نوع المركبه",style: TextStyle(fontWeight: FontWeight.bold),),
                                        trailing:Text("${ss?.type}"),
                                        leading: Icon(CupertinoIcons.car_detailed),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
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
                                            title:Text(" الانطلاقه",style: TextStyle(fontWeight: FontWeight.bold),),
                                            subtitle:Text("${ss?.stringPoint}"),
                                            leading: Icon(CupertinoIcons.location_solid),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child:ListTile(
                                            title:Text(" الوجهه",style: TextStyle(fontWeight: FontWeight.bold),),
                                            subtitle:Text("${ss?.distnitionPoint}"),
                                            leading: Icon(CupertinoIcons.location_solid),
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
                                            title:Text("${ss?.arrivalTime}",style: TextStyle(fontWeight: FontWeight.bold),),
                                            leading: Icon(CupertinoIcons.clock_fill),
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
                                            title:Text("${ss?.returnTime}",style: TextStyle(fontWeight: FontWeight.bold),),
                                            leading: Icon(CupertinoIcons.clock_fill),
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
                                            leading: Icon(CupertinoIcons.person_2_alt),
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
                                            leading: Icon(CupertinoIcons.bed_double_fill),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.6,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: ListTile(
                                        title:Text("حاله المركبه",style: TextStyle(fontWeight: FontWeight.bold),),
                                        trailing:Icon(Icons.ac_unit),
                                        subtitle: ss?.stute == "0" ? Text("غير مكتملة")
                                            : Text(" مكتملة"),
                                        leading: Icon(CupertinoIcons.car_detailed),
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
                                        title:Center(child: Text("الوصف",style: TextStyle(fontWeight: FontWeight.bold),)),
                                        subtitle:Center(child: Text("${ss?.discription}")),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: (){
                                                var mod=snapshot.data?[0];
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Vehical(ss!)));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  onPrimary: Colors.white,
                                                  primary: Colors.brown
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("تعديل ",style: TextStyle(
                                                    fontSize: 20
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () async {
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
                                                          "هل تريد حذف حساب مركبتك الان",
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
                                                                      var res = await apiVehicle.deleteVehicle(ss!.vehicleId,ss.studentId);
                                                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$res")));
                                                                      //Navigator.pop(context);
                                                                      Navigator.pop(context);
                                                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Nav_bar())).reactive;
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
                                              style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  onPrimary: Colors.white,
                                                  primary: Colors.brown
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("حذف المركبة ",style: TextStyle(
                                                    fontSize: 20
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
          ) ,
          // width: double.infinity,

        ),
      ),
    );

  }


}
