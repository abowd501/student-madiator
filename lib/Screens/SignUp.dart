import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Model/Student.dart';
import 'package:student_mediator/Screens/Login.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';
import 'package:student_mediator/Services/StudentApi.dart';

import '../main.dart';
import 'SignUp.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passToggle = true;
  StudentApiService apiStudent= StudentApiService();

  TextEditingController name=TextEditingController();
  TextEditingController rugsNum=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController collage=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController level=TextEditingController();
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
  final _formKey1=GlobalKey<FormState>();

 pos(StudentModel s)async{

  var url = Uri.parse('http://$localhostip/Api_Student_m/SignUp.php');
  var req = http.MultipartRequest('POST', url);
  req.files.add(await http.MultipartFile.fromPath('image2', pickerImage!.path));
  req.fields.addAll(s.toJson());
  var res = await req.send();

  if (res.statusCode == 200 ) {
    final resBody = await res.stream.bytesToString();
  var dd=await json.decode(resBody);
    await prefs.setString("Student_Id", "${dd["Student_Id"]}");
    await prefs.setString("Role_Id", "${dd["Role_Id"]}");
    await prefs.setString("Email", "${dd["Email"]}");
   return dd['message'];

  }

}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override



  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
            height:MediaQuery.of(context).size.height*1.3,
            decoration: BoxDecoration(
              image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Stack(
                children: [
                  Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: double.infinity,
                       //   padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: SafeArea(child: Text("انشاء حساب" ,style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),)))),
                      SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        //height: MediaQuery.of(context).size.height*1.0,
                        width:  MediaQuery.of(context).size.width*1.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(60),topRight: Radius.circular(60)),
                            color: Colors.white
                        ),
                        child: SafeArea(
                          child: Form(
                            key: _formKey1,
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Text("أنشاء حساب",style:  TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    child: TextFormField(
                                      controller: name,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(val.toString().isNum || val!.isEmpty){
                                          return "الحقل فاضي او القيمة رقميه";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown ,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Colors.brown, )),
                                        label: Text("اسم المستخدم",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),textDirection: TextDirection.rtl,),
                                        prefixIcon:Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.account_circle_outlined,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: TextFormField(
                                      controller: rugsNum,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(!val.toString().isNum || val!.isEmpty){
                                          return "الحقل فاضي او القيمة ليست رقميه";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown ,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Colors.white, )),
                                        label: Text("رقم القيد",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
                                        prefixIcon:Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.confirmation_num_outlined,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    child: TextFormField(
                                      controller: phone,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(!val.toString().isPhoneNumber || val!.isEmpty){
                                          return "الحقل فاضي او طول الرقم اقل من المطلوب ";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color(0xffbb8a52), )),
                                        label: Text("رقم الجوال",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
                                        prefixIcon:Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.phone,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: TextFormField(
                                      controller: email,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(!val.toString().isEmail || val!.isEmpty){
                                          return " الحقل فاضي او القيمة غير صحيحه كايميل";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color(0xffbb8a52), )),
                                        label: Text("E-mail",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
                                        prefixIcon:Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.email_outlined,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: TextFormField(
                                    controller: password,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (val){
                                      if(val.toString().length<6 || val!.isEmpty){
                                        return "الحقل فاضي او القيمة اقل من 6";
                                      }
                                    },
                                    textDirection: TextDirection.rtl,
                                    obscureText: passToggle,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                                      filled: true,
                                      fillColor: Colors.brown,
                                      label: Text("كلمة السر    ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
                                      prefixIcon:Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color(0xffe0e0e0)
                                        ),
                                        child:Icon(Icons.lock_outline_rounded,color: Colors.brown,size: 30,),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: (){
                                          if(passToggle==true){
                                            passToggle=false;
                                          }else{
                                            passToggle=true;
                                          }
                                          setState((){});
                                        },
                                        child: passToggle? Icon(CupertinoIcons.eye_slash_fill,color: Colors.white,):Icon(CupertinoIcons.eye_fill),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: TextFormField(
                                   // controller: password,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (val){
                                      if(val!=password.text){
                                        return "الحقل فاضي او القيمة اقل من 6";
                                      }
                                    },
                                    textDirection: TextDirection.rtl,
                                    obscureText: passToggle,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                                      filled: true,
                                      fillColor: Colors.brown,
                                      label: Text(" تاكيد كلمة السر    ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
                                      prefixIcon:Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color(0xffe0e0e0)
                                        ),
                                        child:Icon(Icons.lock_outline_rounded,color: Colors.brown,size: 30,),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: (){
                                          if(passToggle==true){
                                            passToggle=false;
                                          }else{
                                            passToggle=true;
                                          }
                                          setState((){});
                                        },
                                        child: passToggle? Icon(CupertinoIcons.eye_slash_fill,color: Colors.white,):Icon(CupertinoIcons.eye_fill),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: TextFormField(
                                      controller: collage,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(val.toString().isNum || val!.isEmpty){
                                          return "الحقل فاضي او القيمة رقميه";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown ,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color(0xffbb8a52), )),
                                        label: Text("الكليه",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
                                        prefixIcon:Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.cabin_sharp,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    child: TextFormField(
                                      controller: address,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(val.toString().isNum || val!.isEmpty){
                                          return "الحقل فاضي او القيمة رقميه";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown ,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color(0xffbb8a52), )),
                                        label: Text("العنوان",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
                                        prefixIcon:Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.school_outlined,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: TextFormField(
                                      controller: level,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (val){
                                        if(val.toString().isNum || val!.isEmpty){
                                          return "الحقل فاضي او القيمة رقميه";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        fillColor:Colors.brown ,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color(0xffbb8a52), )),
                                        label: Text("المستوى",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
                                        prefixIcon:Container(

                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffe0e0e0)
                                          ),
                                          child:Icon(Icons.leaderboard_outlined,color: Colors.brown,size: 30,),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25,),
                                Padding(
                                  padding:  EdgeInsets.all(10),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width*0.6,
                                    child: Material(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                        onTap: () async{
                                          if(pickerImage.toString()=="null"){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("  تاكد من اضافة صورة لحسابك")));

                                          }
                                          if(_formKey1.currentState!.validate()==true){
                                            StudentModel stud= StudentModel(
                                              name: name.text,
                                              rugsNum: rugsNum.text,
                                              phone: phone.text,
                                              email: email.text,
                                              password: password.text,
                                              collage: collage.text,
                                              address: address.text,
                                              level: level.text,
                                              image: "klkl",
                                              studentId: "1",
                                              roleId: '1'
                                          );
                                            var res=await pos(stud);
                                            if(res=="200"){
                                               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Nav_bar()));
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تمت عملبة التسجيل")));
                                            }else{
                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$res")));

                                    }}
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 0),
                                            child: Text(" أنشاء حساب",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(" لديك حساب",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextButton(onPressed:(){
                                      Navigator.pushReplacement(context,MaterialPageRoute(
                                          builder: (context)=>Login()));
                                    },
                                        child: Text("تسجيل الدخول",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.brown
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
                              ],
                            ),
                          ),
                        ),

                      )
                    ],
                  ),
                  Positioned(
                      top: 140,
                      left: MediaQuery.of(context).size.width*0.37,
                      child:Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child:Stack(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: pickerImage!=null?Image.file(File(pickerImage!.path),fit: BoxFit.cover,):Icon(CupertinoIcons.person_alt,size: 130,color: Colors.black54,),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: IconButton(icon: Icon(Icons.play_for_work_outlined,),
                                    onPressed: () {
                                   pickerGallery();
                                    },)),
                            ),
                          ],

                        ),
                      )
                  ),

                ],
              ),

            )
        ),
      ),
    );
  }
}
