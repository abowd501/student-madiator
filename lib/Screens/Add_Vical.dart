import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Vehicle.dart';
import 'package:student_mediator/Screens/Profile.dart';
import 'package:student_mediator/Services/VehicleApi.dart';
import 'package:http/http.dart'as http;

import '../Model/Student.dart';
import '../main.dart';
import 'Nav_bar.dart';

class Add_Vehical extends StatefulWidget {
  const Add_Vehical({super.key});

  @override
  State<Add_Vehical> createState() => _Edit_AccountState();
}

class _Edit_AccountState extends State<Add_Vehical> {
  TextEditingController type = TextEditingController();
  TextEditingController seats = TextEditingController();
  TextEditingController desc = TextEditingController();
  VehicleApiService apiVehicle = VehicleApiService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<String> drop = [
    "المكلاء",
    "الديس",
    "الشرج",
    "فوة",
    "الشافعي",
  ];
  List<String> drop2 = [
    '7:00',
    '8:00',
    '9:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
  ];
  String? stringPoint = "المكلاء";
  String? distnitionPoint = "فوة";
  String? returnTime = '8:00';
  String arrivalTime = '13:00';
  String? tr;
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
   pos(VehicleModel s)async{
    var url = Uri.parse('http://192.168.43.195/Api_Student_m/Vehicle.php');
    var req = http.MultipartRequest('POST', url);
    for(final image in pickerImage){
      final mulmage=await http.MultipartFile.fromPath('image[]', image.path);
      req.files.add(mulmage);
    }
    req.fields.addAll(s.toJson());
    req.fields["Vehicle_Id"]='22';
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Widget build(BuildContext context) {
    get();
    return Material(
      child: Container(
        width: double.infinity,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/apartment/aparment-3.png"),
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.shade100.withOpacity(0.6),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context, MaterialPageRoute(
                                builder: (context) => Profile()));
                          },
                          icon: Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Text("اضافة مركبة", style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox()
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Stack(
                          children: [
                            pickerImage.isNotEmpty?
                              Container(
                                height: 200,
                                color: Colors.black38,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: int.parse(pickerImage.length.toString()),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Image.file(File(pickerImage[index].path),);
                                  },
                                ),
                              ):
                                Container(
                                  height: 200,
                                  child: Center(
                                    child: Text("أختار صور لمركبتك"),
                                  ),
                                ),
                            Positioned(
                              top: -1,
                              right: -1,
                              child: IconButton(
                                onPressed: () {
                                  pickerGallery();
                                },
                                icon: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.brown,
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: Icon(Icons.file_download_rounded,color: Colors.white,)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextFormField(
                              controller: type,
                              validator: (value) {
                                if (value!.isEmpty||value.toString().isNum) {
                                  return " الحقل فاضي او القيمة رقمية";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.white12,
                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black),
                                  label: Text("نوع المركبة"),
                                  prefixIcon: Icon(Icons.person)
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("مكان الانطلاق",style: TextStyle(fontWeight: FontWeight.bold),),
                          Container(
                            //    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: DropdownButton<String>(
                                value: stringPoint,
                                isExpanded: true,
                                //menuMaxHeight: 350,
                                elevation: 0,
                                items: drop.map((e) =>
                                    DropdownMenuItem<String>(
                                        value: e,
                                        child: Center(child: Text(e))))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    stringPoint = val.toString();
                                  }
                                  );
                                }
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("مكان الوجهة",style: TextStyle(fontWeight: FontWeight.bold),),
                          Container(
                            //    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: DropdownButton<String>(
                                value: distnitionPoint,
                                isExpanded: true,
                                //menuMaxHeight: 350,
                                elevation: 0,
                                items: drop.map((e) =>
                                    DropdownMenuItem<String>(
                                        value: e,
                                        child: Center(child: Text(e))))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    distnitionPoint = val.toString();
                                  }
                                  );
                                }
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("وقت العودة",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("وقت الانطلاق",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: DropdownButton<String>(
                                    value: arrivalTime,
                                    isExpanded: true,
                                    //menuMaxHeight: 350,
                                    elevation: 0,
                                    items: drop2.map((e) =>
                                        DropdownMenuItem<String>(
                                            value: e,
                                            child: Center(child: Text(e))))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        arrivalTime = val.toString();
                                      }
                                      );
                                    }
                                ),
                              ),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: DropdownButton<String>(
                                    value: returnTime,
                                    isExpanded: true,
                                    //menuMaxHeight: 350,
                                    elevation: 0,
                                    items: drop2.map((e) =>
                                        DropdownMenuItem<String>(
                                            value: e,
                                            child: Center(child: Text(e))))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        returnTime = val.toString();
                                      }
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextFormField(
                              controller: seats,
                              validator: (value) {
                                if (value!.isEmpty||!value.isNum) {
                                  return "الحقل فاضي اوالقيمة غير رقمية";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.white12,
                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black),
                                  label: Text("عدد المقاعد"),
                                  prefixIcon: Icon(Icons.person)
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextFormField(
                              controller: desc,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الحقل فاضي";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.white12,
                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black),
                                  label: Text("الوصف"),
                                  prefixIcon: Icon(Icons.person)
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 55,
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate() &&pickerImage.isNotEmpty) {
                                      VehicleModel vehicle = VehicleModel(
                                          vehicleId: "1",
                                          type: type.text,
                                          stringPoint: stringPoint.toString(),
                                          distnitionPoint: distnitionPoint.toString(),
                                          arrivalTime: arrivalTime,
                                          returnTime: returnTime.toString(),
                                          numSeats: seats.text,
                                          stute: '0',
                                          discription: desc.text,
                                          studentId: tr.toString(), images:"1"
                                      );
                                     var res = await apiVehicle.addVehicle(vehicle,pickerImage);
                                      //pos( vehicle);
                                      //SharedPreferences prefs=await SharedPreferences.getInstance() ;
                                     //String? id= await prefs.getString("Vehicle_Id");

                                  //   print(id?.isEmpty);

                                      //print(res);
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$res")));

                                      Navigator.pop(context, MaterialPageRoute(builder: (context) => Nav_bar()));
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Nav_bar())).reactive;

                                    } else {
                                      print("fiald");
                                    }
                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Account()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide.none,
                                      shape: const StadiumBorder(),
                                      onPrimary: Colors.black,
                                      primary: Colors.brown
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("أضافة", style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)

                        ],

                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        // width: double.infinity,

      ),
    );
  }

  get() async {

      tr = await prefs.getString("Student_Id") ?? "nulll";
  }
}