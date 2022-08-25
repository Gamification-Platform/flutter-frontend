import 'dart:developer';

import 'package:BUPLAY/responsive/mobile_screen_layout.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:BUPLAY/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _gotoHomeScreen(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => (const MobileScreenLayout())));
    }
    return DefaultScaffold(
      body:Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login Page',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),

              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),

              Container(
                  height: 50,
                  width: 20,
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      log("login  clicked");
                      final prefs = await SharedPreferences.getInstance();
                      try{
                        final studentCredentials= await StudentAuthHttp.loginStudent(nameController.text, passwordController.text);
                        prefs.setString(PREFERENCE_TOKEN_ID,studentCredentials.token);
                        prefs.setString(PREFERENCE_STUDENT_EMAIL,nameController.text+"@bennett.edu.in");
                        _gotoHomeScreen();
                      }
                      catch (e){
                          log("$e");
                      }
                    },
                  )
              ),

            ],
          )),
    );
  }
}