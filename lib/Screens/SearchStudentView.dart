import 'package:BUPLAY/models/student_details.dart';
import 'package:BUPLAY/services/transaction_http.dart';
import 'package:BUPLAY/utils/Styles.dart';
import 'package:BUPLAY/utils/Widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_detail.dart';
import '../services/students_http.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';


class SearchStudentView extends StatefulWidget {
  const SearchStudentView({Key? key}) : super(key: key);

  @override
  State<SearchStudentView> createState() => _SearchStudentViewState();
}

class _SearchStudentViewState extends State<SearchStudentView> {
  TextEditingController amountController = TextEditingController();
  final _studentSearchController = TextEditingController();
  String studentSearching =' ';
  String _selectedStudentId="";
  String _staffId = "";
  StudentDetails? _selectedStudent;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _staffId = prefs.getString(PREFERENCE_PROFESSOR_EMAIL)!;
      });
    });
  }
    showStudentDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: kDarkPrimaryColor,
        content: Container(

          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Text("Name ${_selectedStudent?.first_name} ${_selectedStudent?.last_name}"),
              Text("Batch ${_selectedStudent?.batch}"),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Sigma Amount',
                  )
                  ,
                  keyboardType:  TextInputType.number,

                ),
              ),

            ],
          ),
        ),
        actions: <Widget>[
          BasicButton(onPress: Navigator.of(context).pop, buttonText: 'Cancel'),
          BasicButton(onPress: () async {
            TransactionDetail transactionDetail=await TransactionHttp.makeSigmaTransaction(_staffId, _selectedStudent!.bennett_email, int.parse(amountController.text));
            print("${transactionDetail.id} this is the id transactionnnnnnnnnnnnnnnn");
            if(transactionDetail!=null){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:                   Text("Transaction successful with id ${transactionDetail.id}",
                ),
                )
              );
              Navigator.of(context).pop();

            }
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
            BasicButton(onPress: () async {
             await getSelectedStudent();
              showStudentDialog(context);
            }, buttonText: 'Search')
          ],
        ),

      ),
    );
  }

  getSelectedStudent() async {
    StudentDetails studentDetails= await StudentDetailsHttp.getStudentDetail('${_studentSearchController.text}@bennett.edu.in');
    setState((){
      _selectedStudent=studentDetails;
    });
    print("${_selectedStudent?.bennett_email} is the studdenyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyt mail");
    }
}
