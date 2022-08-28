import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/staff_details.dart';
import '../models/student_details.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;


class StaffDetailsHttp{
  static final getEndPoint="${baseUrl}api/students/";
  static Future<StaffDetails>  getStaffDetail(String staffId) async {
    final prefs = await SharedPreferences.getInstance();
    final url=Uri.parse("$getEndPoint$staffId");
    final token = prefs.get(PREFERENCE_TOKEN_ID);
    final response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    if (response.statusCode == 200) {
      return StaffDetails.fromMap(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}