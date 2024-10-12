
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _AboutState();
}

class _AboutState extends State<Privacy> {
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
        title: Text("سياسة الخصوصية"),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("images/app/Bg-3.png"),
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
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                       // borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(

                        children: [
                          Container(
                            width: double.infinity,
                            height:40,
                            decoration: BoxDecoration(
                                color: Colors.brown.shade50,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "السياسة والخصوصية ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
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


 باعتبارنا مطوري [تطبيق الوسيط الطلابي ]، نود أن نقدم المزيد من التفاصيل حول سياسة الخصوصية والأمان لدينا:

الالتزام بالقوانين والمعايير:
نلتزم بجميع القوانين والمعايير ذات الصلة بحماية البيانات الشخصية، كما نراجع باستمرار سياساتنا للتأكد من مواكبتها للتطورات التنظيمية والتقنية.

• الحد الأدنى من البيانات:
نجمع فقط المعلومات الضرورية لتقديم خدماتنا بكفاءة، مثل معلومات التسجيل الأساسية وبيانات استخدام التطبيق لتحسين الأداء. ولن نطلب أي بيانات شخصية حساسة دون الضرورة الملحة.

• إجراءات الأمان المتطورة:
نستخدم أحدث التقنيات الأمنية لحماية بياناتكم، بما في ذلك التشفير المتقدم وإجراءات التحقق ذات الخطوتين. كما نقوم بفحوصات أمنية دورية للكشف عن أي ثغرات محتملة.


• حماية الخصوصية في جميع مراحل التطوير:
نراعي مبادئ الخصوصية منذ البداية في تصميم وتطوير التطبيق، من خلال تقييم المخاطر وتضمين آليات الحماية اللازمة.

إذا كان لديكم أي استفسارات أخرى، لا تتردد في التواصل معنا. نحن ملتزمون بحماية خصوصيتكم وأمنكم.
                            ''',
                            style: TextStyle(
                                fontSize: 18,
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
