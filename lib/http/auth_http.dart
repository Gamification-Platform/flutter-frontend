import 'dart:convert';

import '../models/student_auth.dart';
import '../utils/global_variables.dart';
import 'package:http/http.dart' as http;
class StudentAuthHttp{
  static final postEndPoint="${baseUrl}api/auth/";
  static Future<StudentAuth> loginStudent(String username,String password) async{
    final url = Uri.parse(postEndPoint);
    final response = await http.post(url,  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String, String>{
          'username': username,
          'password':password
        })
    );
    return StudentAuth.fromMap(jsonDecode(response.body));
  }
}
