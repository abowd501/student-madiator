

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_mediator/Model/Vehicle.dart';
import 'package:student_mediator/Screens/Booking.dart';
import 'package:student_mediator/Services/VehicleApi.dart';
import '../main.dart';
import 'Vehical_Details.dart';

class Vehical extends StatefulWidget {
  const Vehical({super.key});

  @override
  State<Vehical> createState() => _VehicalState();
}

class _VehicalState extends State<Vehical> {
   String tr='';
  get()async {
    tr = prefs.getString("Student_Id")!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            height:MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image:DecorationImage(image: AssetImage("images/app/Bg-1.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                SizedBox(height: 5),
                //----------------------------------------------
                Container(
                //  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Colors.brown,
                      borderRadius:BorderRadius.circular(20.0),
                    ),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text("المركبات",style: TextStyle(
                            fontSize: 18,
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text("تفاصيل الحجز",style: TextStyle(
                            fontSize: 18,
                        ),),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child:TabBarView(
                      children: [
                        Vehical_View(),
                        Booking(tr!.toString())
                      ],
                    )
                ),
              ],
            ) ,
            // width: double.infinity,

          ),
        ),
      ),

    );
  }
}
class Vehical_View extends StatefulWidget {
  const Vehical_View({super.key});

  @override
  State<Vehical_View> createState() => _Vehical_ViewState();
}

class _Vehical_ViewState extends State<Vehical_View> {


  VehicleApiService apiVehicle=VehicleApiService();
  String? vehicleImage="http://$localhostip/Api_Student_m/Images/Vehicle/";

  List<VehicleModel> seardata=[];
  Future _vehicle()async{
    final c=await apiVehicle.fetchVehicle();

    setState(() {
      seardata=c.where((element) => element.stute=='0') .toList();
      print("$seardata");
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vehicle();
  }
  int myacount=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           SizedBox(height: 10,),
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
                    element.type.contains(val.toString()) ||
                        element.stringPoint.contains(val.toString()) ||
                        element.returnTime.contains(val.toString()) ||
                        element.arrivalTime.contains(val.toString()) ||
                        element.distnitionPoint.contains(val.toString()))
                        .toList();
                    setState(() {
                      seardata = ls;
                    });
                  }else{
                    _vehicle();
                  }
                },
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                    label: Text("البحث",style: TextStyle(fontSize: 20),),
                    /*suffixIcon: InkWell(
                      onTap: (){
                        Filter1(context, onCLosed: (_) {setState(() {});},);
                      },
                      child: Icon(CupertinoIcons.arrow_up_arrow_down_circle,color: Colors.brown,size: 40,),
                    ),*/
                    prefixIcon: InkWell(
                      onTap: (){},
                      child: Icon(CupertinoIcons.search_circle_fill,color: Colors.brown,size: 40,),
                    )


                ),
              ),
            ),
            SizedBox(height: 15,),
            //  SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.8),
                borderRadius: BorderRadius.only(topRight:Radius.circular(25),topLeft:Radius.circular(25))
            ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  FutureBuilder<List<VehicleModel>>(
                    future: apiVehicle.fetchVehicle(),
                    builder: (BuildContext context,  snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return RefreshProgressIndicator();
                      }
                      if(snapshot.connectionState==ConnectionState.done){
                        print(seardata);
                        if(snapshot.hasError){
                          return  Container(
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
                        return  ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: seardata.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Vehical_Details(seardata[index].vehicleId.toString(),seardata[index].studentId.toString())));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children:  [
                                        Text("الانطلاق:${seardata[index].stringPoint}",style:TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),
                                        Text("الوجهه:ا${seardata[index].distnitionPoint}",style:TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),
                                        Text("وقت الذهاب:${seardata[index].arrivalTime}",style:TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),
                                        Text("العوده:${seardata[index].returnTime}",style:TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),),


                                      ],
                                    ),
                                    Container(
                                      height: 150,
                                      width:160,
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                          image:DecorationImage(image: NetworkImage("$vehicleImage${seardata![index].images?.split(",").first.split(" ").last}"),fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },);
                      }
                      return CircularProgressIndicator();
                    },

                  ),

                ],
              ),
            ),
           // SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
