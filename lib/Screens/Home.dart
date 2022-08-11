import 'package:BUPLAY/models/student_details.dart';
import 'package:BUPLAY/services/students_http.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/EventCard.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:BUPLAY/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/XP_bar.dart';
import '../utils/colors.dart';
import 'Profile_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int xpPercent = 50;
int level = 20;

showDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>   ProfilePage()));
            },
            child:  const Text('Profile Page'),
          ),
        ],
      );
    },
  );
}

class _HomeScreenState extends State<HomeScreen> {
  String _studentId="";
  @override
  initState()  {
    print("this is  in init state");
    SharedPreferences.getInstance().then((prefs){
      print("this is in init state with pref");
      setStudentId(
          prefs.getString(PREFERENCE_STUDENT_EMAIL)
      );
    });
    super.initState();
  }
  void setStudentId(String? id){
    setState((){
      _studentId=id!;
    });
    print("${_studentId}this is the id");
  }
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: kDarkPrimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialogBox(context);
                },
                child: FutureBuilder<StudentDetails>(
                  future: StudentDetailsHttp.getStudentDetail(_studentId),
                  builder: (context,snapshot){

                    if (snapshot.hasData){
                      return StudentDetailView(studentDetails: snapshot.data);
                    }
                    if(snapshot.hasError){
                      print(snapshot.error);
                      return Text(snapshot.error.toString());
                    }
                    return Text("what is wrong");
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Event List',
                style: kLightTextStyle.copyWith(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Event_Card(
                        eventName: "eventName",
                        eventDate: 'eventDate',
                        eventTime: 'eventTime',
                        eventVenue: 'eventVenue',
                        eventDescription:
                            "Hey You,We have been discussing an NFT project inside Discord and finally started building one.We did our 1st part of brainstorming on 12th July'22 (Tuesday) and we will be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finish the plan.",
                        eventImage: const Image(
                          image: NetworkImage('https://bit.ly/3IHowRx'),
                        ),
                        buttonText: 'buttonText',
                        onButtonPress: () {}),
                    const SizedBox(
                      width: 20,
                    ),
                    Event_Card(
                        eventName: "eventName",
                        eventDate: 'eventDate',
                        eventTime: 'eventTime',
                        eventVenue: 'eventVenue',
                        eventDescription:
                            "Hey You,We have been discussing an NFT project inside Discord and finally started building one.We did our 1st part of brainstorming on 12th July'22 (Tuesday) and we will be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finishwill be taking it forward today to finish the plan.",
                        eventImage: const Image(
                          image: NetworkImage('https://bit.ly/3IHowRx'),
                        ),
                        buttonText: 'buttonText',
                        onButtonPress: () {})
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StudentDetailView extends StatelessWidget {
  StudentDetailView({
    Key? key,
    required this.studentDetails
  }) : super(key: key);
  StudentDetails? studentDetails;
  @override
  Widget build(BuildContext context) {
    final String studentName="${studentDetails?.first_name} ${studentDetails?.last_name}";
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: kNeutralColor,
                  radius: 60,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      studentName,
                      style: kDarkTextStyle,
                    ),
                    const SizedBox(height: 10),
                    XpBar(
                      xpPercent: xpPercent,
                      level: level,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Sigma',
                          style: kDarkTextStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Alpha',
                          style: kDarkTextStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
