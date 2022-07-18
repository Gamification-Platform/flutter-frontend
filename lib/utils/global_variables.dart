import 'package:BUPLAY/Screens/Home.dart';
import 'package:BUPLAY/Screens/Profile_Screen.dart';
import 'package:BUPLAY/Screens/leaderboardScreen.dart';
import 'package:flutter/material.dart';

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const LeaderBoardScreen(),
  const ProfilePage(),
];

//String currentUserId = FirebaseAuth.instance.currentUser!.uid;
String currentUserName = 'User';
String currentEnrollment = 'E21CSEU0246';
String currentName = 'Swaraj Bachu';

List<String> groups = ['G1','G2','G3','G4','G5'];

List<String> batches = ['EB1','EB2','EB3','EB4','EB5','EB6','EB7','EB8','EB9','EB10','EB11','EB12','EB13'
,'EB14','EB15','EB16','EB17','EB18','EB19','EB20','EB21','EB22','EB23','EB24','EB25','EB26','EB27','EB28','EB29','EB30'];

List<String> semester = ['I','II','III','IV','V','VI','VII','VIII'];