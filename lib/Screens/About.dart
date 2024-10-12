
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.brown,
          ),
        ),
        title: Text("عن التطبيق"),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              //    color: Color(0xec574c47),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                     // padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.brown.shade50,
                          //borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(

                        children: [
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.brown.shade50,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "النبذة",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5),
                            child: Divider(
                              height: 10,
                              color: Colors.black,
                            ),
                          ),
                          Text('''
                     

"الوسيط الطلابي هو تطبيق مصمم لمساعدة الطلاب القادمين من بلدان أخرى والبعيدة أثناء دراستهم في الجامعات. يوفر التطبيق سهولة البحث عن شقق سكنية تناسب احتياجاتهم ومتطلباتهم المالية، مما يسمح للطلاب بتحديد ميزانياتهم واشتراطاتهم الخاصة. إضافة إلى ذلك، يتيح التطبيق للطلاب تقديم طلبات للشقق المعروضة مباشرةً من خلال التطبيق، دون الحاجة إلى الاتصال بالمالك. للطلاب الذين يتقدمون بطلبات للشقق عبر التطبيق، سيتم منحهم خصم بنسبة 25% على القيمة الإيجارية. 

علاوة على ذلك، يقدم التطبيق ميزة عرض إعلانات للطلاب المتفوقين في الجامعات، مما يمنحهم فرصًا إضافية للتواصل مع جهات محتملة للتوظيف أو مواصلة الدراسات العليا. كما يتيح التطبيق للطلاب عرض مركباتهم الخاصة كمصدر دخل إضافي. بهذه الميزات، يهدف الوسيط الطلابي إلى تحسين تجربة الطلاب الدوليين وتسهيل انتقالهم إلى الحياة الجامعية."
                            
                            ''',
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(height: 10,),



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

    );
  }
}
