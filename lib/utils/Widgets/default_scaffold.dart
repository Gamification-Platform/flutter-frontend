import 'package:flutter/material.dart';

import '../colors.dart';
class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    Key? key,
    required this.body
  }) : super(key: key);

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: primaryColor,
        centerTitle: false,
        title: const Text(
          'BU Play',
          style: TextStyle(
            fontSize: 20,
            color: kDarkPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: kDarkPrimaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}