import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_mediator/Model/Vehicle_imsge.dart';

import '../Model/Admin.dart';
import '../main.dart';

class VehicleImsgeApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Vehicle/Get_Image.php";

  Future<List<Vehicle_ImsgeModel>> fetchVehicleImsgeId(Id) async {
    final response = await http.get(Uri.parse(apiUrl+"?id=$Id"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Vehicle_ImsgeModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  postImage(id,pickerImage)async{
    var url = Uri.parse('http://$localhostip/Api_Student_m/Vehicle/Get_Image.php');
    var req = http.MultipartRequest('POST', url);
    for(final image in pickerImage){
      final mulmage=await http.MultipartFile.fromPath('image[]', image.path);
      req.files.add(mulmage);
    }
    req.fields["Vehicle_Id"]=id;
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200 ) {
       var v=jsonDecode(resBody);
      return v["message"];
    }
    else {
      print(res.reasonPhrase);
    }
  }
  Future<void> addImage(AdminModel admin) async {
    final response = await http.post(
      Uri.parse("http://localhost/Api_Student_m/Admin/Post.php"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(admin.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add admin');
    }
  }



  Future deleteImage(String id) async {
    final response = await http.delete(Uri.parse('http://$localhostip/Api_Student_m/Vehicle/Delete_Image.php?id=$id'));

    if (response.statusCode != 204) {
     return "تم الحذف";
    }
    else{
      return "لم يتم الحذف";
    }
  }
}
