import 'package:BUPLAY/Screens/EditProfile.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:BUPLAY/utils/XP_bar.dart';
import 'package:BUPLAY/utils/colors.dart';
import 'package:BUPLAY/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/Styles.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

int xpPercent = 50;
int level = 20;
int alphaCoins = 100;
int sigmaCoins = 300;



showDialogBox2(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: (){
              WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>   EditProfile()));
              });

            },
            child:  const Text('Edit Profile'),
          ),
        ],
      );
    },
  );
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return
       DefaultScaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 400,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed:() => Navigator.of(context).maybePop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: kAccentColor,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.58,
                          ),
                          IconButton(
                            onPressed: ()=>showDialogBox2(context),

                            icon: Icon(
                              Icons.more_vert,
                              color: kAccentColor,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: kAccentColor,
                      ),
                      Text(
                        'Name',
                        style: kDarkTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      XpBar(
                        xpPercent: xpPercent,
                        level: level,
                        barWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: kNeutralColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/alphaCoin.png',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('$alphaCoins',
                                    style: kDarkTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: kNeutralColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
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
                                Text('$sigmaCoins',
                                    style: kDarkTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Information',
                        style: kLightTextStyle.copyWith(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const FieldBox(label: 'Name:', value: 'Swaraj'),
                      const SizedBox(
                        height: 10,
                      ),
                      const FieldBox(label: 'Enroll:', value: 'E21CSEU0246'),
                      const SizedBox(
                        height: 10,
                      ),
                      const FieldBox(label: 'Semester:', value: '3rd'),
                      const SizedBox(
                        height: 10,
                      ),
                      const FieldBox(label: 'Group:', value: 'G2'),
                      const SizedBox(
                        height: 10,
                      ),
                      const FieldBox(label: 'Batch:', value: 'EB12'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class FieldBox extends StatelessWidget {
  final String label;
  final String value;
  const FieldBox({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: kLightTextStyle,
          ),
          const SizedBox(width: 20),
          Text(
            value,
            style: kLightTextStyle,
          ),
        ],
      ),
    );

  }
}
