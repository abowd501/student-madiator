import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Screens/Profile.dart';

import '../Model/Student.dart';
import '../main.dart';

class Edit_Account extends StatefulWidget {
   Edit_Account(this.student);
   StudentModel student;

  @override
  State<Edit_Account> createState() => _Edit_AccountState(student);
}

class _Edit_AccountState extends State<Edit_Account> {
  @override
  String? id;
  TextEditingController _image=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _level=TextEditingController();
  TextEditingController _address=TextEditingController();
  String? userImage="http://$localhostip/Api_Student_m/Images/Students/";

  _Edit_AccountState(this.student);
  StudentModel student;

  ImagePicker imagePicker=ImagePicker();
  XFile? pickerImage;
  Future<void> pickerGallery()async{
    try{
      var image=await imagePicker.pickImage(source: ImageSource.gallery);
      if(image!=null){
        setState(() {
          pickerImage=image;
        });
      }
    }catch(error){
      print("good$error");
    }
  }
  pos(StudentModel s)async{
    var url = Uri.parse('http://$localhostip/Api_Student_m/student/Put.php');
    var req = http.MultipartRequest('POST', url);
    if(_image.text==''){
      req.files.add(await http.MultipartFile.fromPath('image2', pickerImage!.path));
    }
    req.fields.addAll(s.toJson());
    var res = await req.send();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final resBody = await res.stream.bytesToString();
      //var dd=await json.decode(resBody);
      return resBody;
    }
    else {
      print("11");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id= student.studentId;
    _image.text=student.image!;
    _email.text=student.email!;
    _phone.text=student.phone!;
    _level.text=student.level!;
    _address.text=student.address!;
  }
  Widget build(BuildContext context) {
    return  Material(
      child: SingleChildScrollView(
        child: Container(

          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: _image.text.isImageFileName?DecorationImage(image: NetworkImage("$userImage${_image.text}"), fit: BoxFit.cover):
            DecorationImage(image:AssetImage("images/app/person.png"), fit: BoxFit.cover)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x619E9E9A),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30,
              ),
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
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
                            SizedBox(),
                            Text("تعديل الحساب",style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),),IconButton(
                              onPressed: (){ Navigator.pop(context, MaterialPageRoute(builder: (context)=>Profile()));},
                              icon:Icon(CupertinoIcons.arrow_left),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: _image.text.isImageFileName?Image.network("$userImage${_image.text}"):pickerImage!.path.isNotEmpty?Image.file(File(pickerImage!.path.toString())):Image.asset("images/app/person.png",fit: BoxFit.cover,),
                                  ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child:IconButton(
                                    onPressed: () async {
                                      await pickerGallery();
                                      setState(() {
                                        _image.text='';
                                      });

                                    },
                                    icon:Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Icon(Icons.camera_alt,)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Form(
                            child:Column(
                             children: [
                                 Container(
                                       decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(20)
                                      ),
                                  child: TextField(
                                    controller: _email,
                                       decoration: InputDecoration(
                                        prefixIconColor: Colors.white12,
                                       floatingLabelStyle: TextStyle(color: Colors.black),
                                       label: Text("الايميل"),
                                       prefixIcon: Icon(Icons.mail)
                                      ),
                                     ),
                                    ),
                                 SizedBox(height: 20,),
                                 Container(
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: TextField(
                                   controller: _phone,
                                   decoration: InputDecoration(
                                       prefixIconColor: Colors.white12,
                                       floatingLabelStyle: TextStyle(color: Colors.black),
                                       label: Text("رقم الجوال"),
                                       prefixIcon: Icon(Icons.phone_android)
                                   ),
                                 ),
                               ),
                                 SizedBox(height: 20,),
                                 Container(
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: TextField(
                                   controller: _level,
                                   decoration: InputDecoration(
                                       prefixIconColor: Colors.white12,
                                       floatingLabelStyle: TextStyle(color: Colors.black),
                                       label: Text("المستوى"),
                                       prefixIcon: Icon(Icons.co_present)
                                   ),
                                 ),
                               ),
                                 SizedBox(height: 20,),
                                 Container(
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: TextField(
                                   controller: _address,
                                   decoration: InputDecoration(
                                       prefixIconColor: Colors.white12,
                                       floatingLabelStyle: TextStyle(color: Colors.black),
                                       label: Text("العنوان"),
                                       prefixIcon: Icon(CupertinoIcons.location_solid)
                                   ),
                                 ),
                               ),
                                 SizedBox(height: 20,),
                                 SizedBox(
                                  height: 55,
                                  width: 170,
                                  child: ElevatedButton(
                                           onPressed: () async {
                                             StudentModel stud= StudentModel(
                                                 name: "_name.text",
                                                 rugsNum:"1",
                                                 phone: _phone.text,
                                                 email: _email.text,
                                                 password: "0",
                                                 collage:"0",
                                                 address: _address.text,
                                                 level: _level.text,
                                                 image: "klkl",
                                                 studentId: id,
                                                 roleId: '1'
                                             );
                                             var res=await pos(stud);
                                             print("$res");
                                             setState(() {
                                               Navigator.pop(context);
                                             });

                                                  },
                                   style: ElevatedButton.styleFrom(
                                   side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                  onPrimary: Colors.black,
                                   primary: Colors.brown
                                   ),
                                    child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                     child: Text("تأكيد",style: TextStyle(
                                     fontSize: 20,
                                       color: Colors.white
                          ),),
                        ),
                      ),
                    ),
            ],

          ),
                        ),
                      ],
                    ),
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
