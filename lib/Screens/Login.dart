
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Screens/Nav_bar.dart';
import 'package:student_mediator/Services/StudentApi.dart';
import '../Model/Student.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passToggle = true;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  StudentApiService apiStudent=StudentApiService();
clear(){
  email.clear();
  password.clear();
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          //  height:MediaQuery.of(context).size.height*1.0,
            decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
            fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              //  SizedBox(height: 40,),
                Container(
                  color: Color(0x6C858585),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("مرحبا " ,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                        Text("عزيزي الطالب انظم الينا " ,style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                         fontWeight: FontWeight.bold,
                          decorationColor: Colors.black,
                        ),),
                        Text("للبحث عن مسكنك المناسب " ,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                Container(
                  padding: EdgeInsets.all(10),
                 // height: MediaQuery.of(context).size.height*0.5,
                  width:  MediaQuery.of(context).size.width*1.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(60),topRight: Radius.circular(60)),
                    color: Colors.white
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("تسجل الدخول",style:  TextStyle(
                        fontSize: 22,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Container(
                              child: TextField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  fillColor:Colors.brown ,
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color(0xffbb8a52), )),
                                  label: Text("E-mail",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
                                  prefixIcon:Container(

                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffe0e0e0)
                                    ),
                                    child:Icon(Icons.email_sharp,color: Colors.brown,size: 30,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: TextField(
                          controller:  password,
                          textDirection: TextDirection.rtl,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                            filled: true,
                            fillColor: Colors.brown,
                            label: Text("كلمة السر    ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
                            prefixIcon:Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffe0e0e0)
                              ),
                              child:Icon(Icons.lock,color: Colors.brown,size: 30,),
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
                      SizedBox(height: 25,),
                      Padding(
                        padding:  EdgeInsets.all(10),
                        child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                          child: Material(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () async {
                                StudentModel student=StudentModel(
                                    name: '1',
                                    rugsNum: '1',
                                    phone: '1',
                                    email: email.text,
                                    password: password.text,
                                    collage:'1',
                                    address: '1',
                                    level: '1',
                                    image: "1",
                                    studentId: "1",
                                    roleId: '1'
                                );
                               var res=await apiStudent.login(student,context);
                               print(res);
                               // SharedPreferences prefs=await SharedPreferences.getInstance() ;
                               if( res){
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( "تم عملية التسجل ينجاح")));
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Nav_bar()));
                              }if(res==false){
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( "  تأكد من ان الايميل و كلمة السر صحيحين")));
                               }
                               },
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  child: Text("تسجل الدخول",style: TextStyle(
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
                          Text("ليس لديك حساب",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(onPressed:(){

                            Navigator.pushReplacement(context,MaterialPageRoute(
                                builder: (context)=>SignUp()));
                          },
                              child: Text("أنشاء حساب",
                                style: TextStyle(
                                    fontSize: 19,
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
              ],
            ),
          )
        ),
      ),
    );
  }
}
