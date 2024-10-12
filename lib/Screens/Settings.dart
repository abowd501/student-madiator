
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_mediator/Screens/About.dart';
import 'package:student_mediator/Screens/Add_Vical.dart';
import 'package:student_mediator/Screens/Complaints.dart';
import 'package:student_mediator/Screens/Login.dart';
import 'package:student_mediator/Screens/Privacy.dart';
import 'package:student_mediator/Screens/Profile.dart';
import 'package:student_mediator/Screens/Vehical_Profile.dart';
import 'package:student_mediator/main.dart';
//---------------------------------------------------
Future<Object?> customSigninDialog(BuildContext context, String? role,
    {required ValueChanged onCLosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(right: 120),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
           color: Colors.brown.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  SizedBox(height: 20,),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text("الاعدادات",style: TextStyle(color: Colors.white70,fontSize: 20),),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 18),
                        child: Divider(
                          color: Colors.white54,
                          height: 1,
                        ),
                      ),
                      InkWell(
                        onTap: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(CupertinoIcons.profile_circled,color: Colors.white,),
                          ),
                          title: Text("الملف الشخصي",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),
                      role=="2"?InkWell(
                        onTap: () async {
                           String? tr= prefs.getString("Vehicle_Id");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Vehical_Profile()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(CupertinoIcons.car_detailed,color: Colors.white,),
                          ),
                          title: Text("ملف المركبه",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ):
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Vehical()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(CupertinoIcons.add_circled_solid,color: Colors.white,),
                          ),
                          title: Text("أضافة مركبة",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Privacy()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(CupertinoIcons.exclamationmark_shield_fill,color: Colors.white,),
                          ),
                          title: Text("سياسة الخصوصية",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(CupertinoIcons.info_circle_fill,color: Colors.white,),
                          ),
                          title: Text("عن التطبيق",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaints()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(CupertinoIcons.chat_bubble_text_fill,color: Colors.white,),
                          ),
                          title: Text("الشكاوي",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          prefs.remove("Student_Id");
                          Navigator.pop(context);
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                       // Navigator.pop(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.logout,color: Colors.white,),
                          ),
                          title: Text("تسجيل الخروج",style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),




                    ],
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    ),
  ).then(onCLosed);
}
double _value=2000.0;
var _sel="Mukli";


Future<Object?> Filter1(BuildContext context,
    {required ValueChanged onCLosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Container(
      height: double.infinity,
      margin: const EdgeInsets.only(top: 300),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Homef(),
      ),
    ),
  ).then(onCLosed);
}
class Homef extends StatefulWidget {
  const Homef({super.key});

  @override
  State<Homef> createState() => _HomefState();
}

class _HomefState extends State<Homef> {
 List<String> drop=[
    "المكلا",
    "الشرج",
    "الديس",
    "الغوزي",
    "ياعبود",
    "الشافعي",
  ];
 int roms=1;
 int bath=1;
 String? dr="المكلا";
  double _value=2000.0;
  RangeValues _rval=RangeValues (300.0,1000.0);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text("تصفية",style: TextStyle(color: Colors.white70,fontSize: 20),),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 0),
            child: Divider(
              color: Colors.white54,
              height: 1,
            ),
          ),
          Center(
            child: Text("حدد السعر",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ),
          RangeSlider(
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
              min: 100.0,
              max: 1200.0,
              divisions: 22,
              values:_rval,  onChanged: (RangeValues val){setState(()=> _rval=val);}),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("${_rval.start.toInt()}رس",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("${_rval.end.toInt()}رس",style: TextStyle(color: Colors.black,fontSize: 15 ,fontWeight: FontWeight.bold),)),
              ]
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("عدد الغرف",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {roms=1;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: roms==1?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("1",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {roms=2;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: roms==2?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("2",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {roms=3;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color:roms==3?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("3",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {roms=4;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: roms==4?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("4",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {roms=5;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color:roms==5?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("5",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {roms=6;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: roms==6?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("+6",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("عدد الحمامات",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {bath=1;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: bath==1?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("1",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {bath=2;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: bath==2?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("2",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {bath=3;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: bath==3?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("3",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {bath=4;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: bath==4?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("4",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
              InkWell(
                onTap: (){
                  setState(() {bath=5;});
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                        color: bath==5?Colors.orangeAccent:Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("+5",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("الموقع",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),
            ),
          ),
          Container(
         //    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(15)
             ),
             child: DropdownButton<String>(
              value: dr,
                isExpanded: true,

                //menuMaxHeight: 350,
                 elevation: 0,
                items:drop.map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Center(child: Text(e)))).toList(),
                onChanged:(val){
                  setState((){
                      dr=val.toString();
                   }
                  );
                }
          ),
           ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              onTap: ()async{
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setString("fprice", _rval.start.toString()+","+_rval.end.toString());
                prefs.setString("flocation", dr.toString());
                prefs.setString("frooms", roms.toString());
                prefs.setString("fbath", bath.toString());
               Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("موافق"),
              ),
            ),
          )

        ],
      ),
    );
  }
}
