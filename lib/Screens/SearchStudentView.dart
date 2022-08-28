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


  final _studentSearchController = TextEditingController();
  final _sigmaCoinsController = TextEditingController();
  String studentSearching =' ';
  int coinsSending = 0;

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
                print('${snapshot.data!.first_name} + ${snapshot.data!.last_name}');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${snapshot.data!.first_name}  ${snapshot.data!.last_name}',style: kDarkTextStyle,),
                    const SizedBox(height: 10,),
                    Text('${snapshot.data!.bennett_email} ',style: kDarkTextStyle.copyWith(fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('Batch: ${snapshot.data!.batch} ',style: kDarkTextStyle.copyWith(fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('Semester: ${snapshot.data!.current_semester} ',style: kDarkTextStyle.copyWith(fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('Program: ${snapshot.data!.program} ',style: kDarkTextStyle.copyWith(fontSize: 16),),
                    const SizedBox(height: 10,),
                    Text('Enter the number of coins you want to transfer',style: kDarkTextStyle.copyWith(fontSize: 19),),
                    const SizedBox(height: 10,),
                    TextField(
                        style: kLightTextStyle.copyWith(fontSize: 14),
                        controller: _sigmaCoinsController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: kDarkPrimaryColor,
                          hintText: '20',
                          hintStyle: kDarkTextStyle.copyWith(fontSize: 14,),
                          prefixIcon: const Icon(Icons.monetization_on,color: primaryColor,),
                          focusedBorder: const  OutlineInputBorder(
                            borderSide: BorderSide(width: 0,),
                            borderRadius: BorderRadius.all(Radius.circular(20),
                            ),),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text){
                          setState(() {
                            coinsSending = int.parse(_sigmaCoinsController.text);

                          });
                        }
                    ),
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
          BasicButton(onPress: (){
            showDialog(context: context, builder: (BuildContext context){
              return ConfirmationBox(title: 'You are sending ${_sigmaCoinsController.text} Coins',);
            });
          }, buttonText: 'Proceed'),
        ],
      ),
    );
  }
  

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

class ConfirmationBox extends StatelessWidget {
  final String title;
  const ConfirmationBox({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: primaryColor,
        ),
        height: 180,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Icon(Icons.compare_arrows,color: kDarkPrimaryColor,size: 50,),
            const  SizedBox(height: 30,),
            Text(title,style: kDarkTextStyle.copyWith(fontSize: 16),),
            const  SizedBox(height: 10,),
            BasicButton(onPress: (){}, buttonText: "Send")
          ],
        ),
      ),
    );
  }
}

