import 'package:BUPLAY/utils/Styles.dart';
import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final  VoidCallback onPress;
  final String buttonText;
  final Color buttonColor;
  BasicButton({Key? key, required this.onPress, required this.buttonText, this.buttonColor=Colors.deepPurple}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
child: Text(buttonText,),
      )
    );
  }
}
