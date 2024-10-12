
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Login.dart';

class Welcome1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    void _timeNav(){
      Future.delayed(Duration(seconds: 10),(){Get.off(Login());});
    }
    return Material(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/app/Bg-1.png"),fit: BoxFit.cover)
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
          },
          child: Container(
           // padding: EdgeInsets.fromLTRB(0*fem, 10*fem, 0*fem, 150*fem),
            width: double.infinity,
            decoration: BoxDecoration (
              color: Colors.brown.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20*fem),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Container(
                  // autogrouphwryxsq (7KSj3XWWqBVZzB2F8QHWry)
                  width: double.infinity,
                  height: 400*fem,
                  child: Stack(
                    children: [
                      Positioned(
                        // polygon16j9 (35:358)
                        left: 99*fem,
                        top: 94.0000066757*fem,
                        child: Align(
                          child: SizedBox(
                            width: 159*fem,
                            height: 136*fem,
                            child: Image.asset(
                             'images/app/polygon-1.png',
                              width: 159*fem,
                              height: 136*fem,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // polygon2NAs (35:359)
                        left: 40*fem,
                        top: 0*fem,
                        child: Align(
                          child: SizedBox(
                            width: 181.81*fem,
                            height: 187.41*fem,
                            child: Image.asset(
                              'images/app/polygon-2.png',
                              width: 181.81*fem,
                              height: 187.41*fem,
                            ),
                          ),
                        ),
                      ),
                      Positioned
                        (
                        // polygon2NAs (35:359)
                        right: 40*fem,
                        top: 100*fem,
                        child: Align(
                          child: SizedBox(
                            width: 181.81*fem,
                            height: 80.41*fem,
                            child: Image.asset(
                              'images/app/polygon-3.png',
                              width: 181.81*fem,
                              height: 187.41*fem,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100*fem,),
                Container(
                 // width: double.infinity,
                  padding: EdgeInsets.all(10),
                  color: Colors.white70,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Student Mediator",style: TextStyle(
                        fontSize: 30,
                        color: Colors.black

                      ),),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }
}
