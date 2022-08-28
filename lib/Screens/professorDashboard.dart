import 'package:BUPLAY/Screens/SearchStudentView.dart';
import 'package:BUPLAY/Screens/professorFunctions.dart';
import 'package:flutter/material.dart';

import '../utils/Styles.dart';
import '../utils/Widgets/Button.dart';
import '../utils/colors.dart';

class ProfessorDashboard extends StatefulWidget {
  const ProfessorDashboard({Key? key}) : super(key: key);

  @override
  State<ProfessorDashboard> createState() => _ProfessorDashboardState();
}

class _ProfessorDashboardState extends ProfessorFunctions {
  final _enrollEnteredController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Professor Dashboard',
          style: kDarkTextStyle,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
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
                                "Professor  Name",
                                style: kDarkTextStyle,
                              ),
                              Text(
                                "Professor  Email",
                                style: kDarkTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "Department",
                                style: kDarkTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Alloted Coins:',
                                    style: kDarkTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: kNeutralColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/sigmaCoin.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Coins Based on Quiz results',
                  style: kLightTextStyle,
                ),
                const SizedBox(height: 20),
                BasicButton(
                    onPress: () => addNewDialog(context),
                    buttonText: 'Add Coins via Excel')
              ],
            ),
            const SizedBox(height: 20,),
            Text('Allot Coins to individual student',style: kLightTextStyle,),
            const SizedBox(height: 20,),
             TextField(
              controller: _enrollEnteredController,
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
               onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchStudentView()));
               },
            )
          ],
        ),
      ),
    );
  }
}
