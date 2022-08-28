import 'package:BUPLAY/models/student_details.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/Button.dart';
import 'package:flutter/material.dart';

import '../services/students_http.dart';
import '../utils/colors.dart';


class SearchStudentView extends StatefulWidget {
  const SearchStudentView({Key? key}) : super(key: key);

  @override
  State<SearchStudentView> createState() => _SearchStudentViewState();
}

class _SearchStudentViewState extends State<SearchStudentView> {
  showStudentDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: primaryColor,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: FutureBuilder<StudentDetails>(
            future: StudentDetailsHttp.getStudentDetail('${_studentSearchController.text}@bennett.edu.in'),
            builder: (context, snapshot) {
              print('${_studentSearchController.text}@bennett.edu.in');
              if (snapshot.hasData) {
                print('${snapshot.data!.first_name}');
                return Column(
                  children: [
                    Text('StudentName',style: kDarkTextStyle,)
                  ],
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator();
              //Center(child: CircularProgressIndicator());
            },
          ),
        ),
        actions: <Widget>[
          BasicButton(onPress: Navigator.of(context).pop, buttonText: 'Cancel'),
          BasicButton(onPress: (){}, buttonText: 'Proceed'),
        ],
      ),
    );
  }

  final _studentSearchController = TextEditingController();
  String studentSearching =' ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading:
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(
              Icons.arrow_back,
              color: kAccentColor,
            ),
          ),
        title: const Text('Search For The Student',style: kDarkTextStyle,),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: kDarkTextStyle.copyWith(fontSize: 14),
              controller: _studentSearchController,
              decoration:  InputDecoration(
                filled: true,
                fillColor: primaryColor,
                hintText: 'E21CSEU0246',
                hintStyle: kDarkTextStyle.copyWith(fontSize: 14,),
                prefixIcon: const Icon(Icons.person,color: kDarkPrimaryColor,),
                focusedBorder: const  OutlineInputBorder(
                  borderSide: BorderSide(width: 0,),
                  borderRadius: BorderRadius.all(Radius.circular(20),
                ),),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)
                  ),
                ),
              ),
              onChanged: (text){
                setState(() {
                  studentSearching = _studentSearchController.text;
                  print(studentSearching);
                });
              }
            ),
            const SizedBox(height: 10,),
            BasicButton(onPress: ()=> showStudentDialog(context), buttonText: 'Search')
          ],
        ),

      ),
    );
  }
}
