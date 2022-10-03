import 'package:BUPLAY/Screens/admin/Admin_Screen.dart';
import 'package:BUPLAY/Screens/mentor/mentor_dashboard.dart';
import 'package:BUPLAY/Screens/user/EditProfile.dart';
import 'package:BUPLAY/Screens/user/Home.dart';
import 'package:BUPLAY/Screens/auth/login_screen.dart';
import 'package:BUPLAY/Screens/Professor/professorDashboard.dart';
import 'package:BUPLAY/responsive/mobile_screen_layout.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sample',
        theme: ThemeData.dark().copyWith(

      scaffoldBackgroundColor: kDarkPrimaryColor,
          primaryColor: Colors.deepPurple.shade100,
    ),
    home: //MobileScreenLayout()
      //ProfessorDashboard()
       //MentorDashboard()
      LoginScreen()
    );
  }
}

