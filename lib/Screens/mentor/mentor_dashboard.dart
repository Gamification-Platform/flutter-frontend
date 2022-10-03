import 'package:flutter/material.dart';

import '../../models/staff_details.dart';
import '../../services/staff_http.dart';
import '../../utils/Styles.dart';
import '../../utils/colors.dart';



class MentorDashboard extends StatefulWidget {
  const MentorDashboard({Key? key}) : super(key: key);

  @override
  State<MentorDashboard> createState() => _MentorDashboardState();
}

class _MentorDashboardState extends State<MentorDashboard> {
  String _staffId = "";
  String _sigmaCoin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Mentor Dashboard',
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
                      child: FutureBuilder<StaffDetails>(
                        future: StaffDetailsHttp.getStaffDetail(_staffId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return MentorDetails(
                              id: _staffId,
                              name:
                              "${snapshot.data?.first_name} ${snapshot.data?.last_name}",
                              email: snapshot.data?.bennett_email ?? "",
                              department:
                              snapshot.data?.department_code ?? "error",
                              coin: _sigmaCoin,
                            );
                          } else if (snapshot.hasError) {
                            print("${snapshot.error} this is error");
                            return Text("error");
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MentorDetails extends StatelessWidget {
  String id;
  String name;
  String email;
  String department;
  String coin;
  MentorDetails(
      {Key? key,
        required this.id,
        required this.name,
        required this.email,
        required this.department,
        required this.coin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              name,
              style: kDarkTextStyle,
            ),
            Text(
              email,
              style: kDarkTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Department $department",
              style: kDarkTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sigma Coins: ",
              style: kDarkTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: kNeutralColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                      Text(
                        "$coin",
                        style: kDarkTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16),
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
    );
  }
}