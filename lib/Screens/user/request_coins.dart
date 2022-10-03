import 'package:flutter/material.dart';


class RequestCoins extends StatefulWidget {
  const RequestCoins({Key? key}) : super(key: key);

  @override
  State<RequestCoins> createState() => _RequestCoinsState();
}

class _RequestCoinsState extends State<RequestCoins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          'Request Coins',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Text('RequestCoins'),
        ),
      ),
    );

  }
}
