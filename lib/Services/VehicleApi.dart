import 'dart:convert';
import 'package:cross_file/src/types/interface.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Vehicle.dart';
import '../main.dart';

class VehicleApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/vehicle.php";
  Future<List<VehicleModel>> fetchVehicle() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => VehicleModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<VehicleModel>> fetchVehicleID(String id) async {
    final response = await http.get(Uri.parse(apiUrl+"?id=$id"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => VehicleModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

 Future addVehicle(VehicleModel s,pickerImage)async{
    var url = Uri.parse('http://$localhostip/Api_Student_m/Vehicle.php');
    var req = http.MultipartRequest('POST', url);
    for(final image in pickerImage){
      final mulmage=await http.MultipartFile.fromPath('image[]', image.path);
      req.files.add(mulmage);
    }
    req.fields.addAll(s.toJson());
    req.fields["Vehicle_Id"]='22';
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    final rr=jsonDecode(resBody);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      await prefs.setString("Vehicle_Id", rr['id']);
      await prefs.setString("Role_Id", "1");
      print(rr['id']);
      return rr['message'];
    }
    else {
    //  print(res.reasonPhrase);
      return false;
    }
  }
 Future updateVehicle(VehicleModel s,pickerImage)async{
    var url = Uri.parse('http://$localhostip/Api_Student_m/Vehicle/Put.php');
    var req = http.MultipartRequest('POST', url);
    req.fields.addAll(s.toJson());
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    //final rr=jsonDecode(resBody);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      final v = jsonDecode(resBody);
      // print(resBody.split(":")[3]);

      return v["message"];
    }
    else {
    //  print(res.reasonPhrase);
      return false;
    }
  }


  Future deleteVehicle(vehicleId,studentId) async {
    final response = await http.delete(Uri.parse('$apiUrl?id=$vehicleId&Student_Id=$studentId'));
    if (response.statusCode == 200) {
      var res=jsonDecode(response.body);
      await prefs.setString("Role_Id", "1");
      return res["message"];
    }
  }

  Future<int> countVehicle() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final conn=jsonData.length;
      return conn;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
