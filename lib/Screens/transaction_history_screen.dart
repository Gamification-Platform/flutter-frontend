

import 'package:BUPLAY/models/transaction_detail.dart';
import 'package:BUPLAY/services/transaction_http.dart';
import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/global_variables.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _id="";
  String _coin="alpha";
  String _time_period="";
  bool _latest=false;
  @override
  void initState() {
    print("mail ");

    SharedPreferences.getInstance().then((prefs) {
      print(prefs.getString(PREFERENCE_STUDENT_EMAIL));
      setState((){
        _id=prefs.getString(PREFERENCE_STUDENT_EMAIL)!;
      });
    });
    print(_id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(body: Center(
        child:
            Column(
              children: [
                RadioListTile(
                  title: Text("Alpha"),
                  value: "alpha",
                  groupValue: _coin,
                  onChanged: (value){
                    setState(() {
                      _coin = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("Sigma"),
                  value: "sigma",
                  groupValue: _coin,
                  onChanged: (value){
                    setState(() {
                      _coin = value.toString();
                    });
                  },
                ),
                Expanded(child: TransactionList(id: _id,coin: _coin,time_period: _time_period))

              ],
            )
    )
    // Column(
      // children: [
      //   Row(
      //     children: [
      //       RadioListTile(
      //         title: Text("Alpha"),
      //         value: "alpha",
      //         groupValue: _coin,
      //         onChanged: (value){
      //           setState(() {
      //             _coin = value.toString();
      //           });
      //         },
      //       ),
      //       RadioListTile(
      //         title: Text("Sigma"),
      //         value: "sigma",
      //         groupValue: _coin,
      //         onChanged: (value){
      //           setState(() {
      //             _coin = value.toString();
      //           });
      //         },
      //       )
      //     ],
      //   ),
      // // Row(
      // //   children: [
      // //     RadioListTile(
      // //       title: Text("Week"),
      // //       value: "week",
      // //       onChanged: (value){
      // //         setState((){
      // //           _time_period=value.toString();
      // //         }
      // //         );
      // //       }, groupValue: _time_period,
      // //     ),
      // //     RadioListTile(
      // //       title: Text("Month"),
      // //       value: "month",
      // //       onChanged: (value){
      // //         setState((){
      // //           _time_period=value.toString();
      // //         }
      // //         );
      // //       }, groupValue: _time_period,
      // //     )
      // //   ],
      // TransactionList(id: _id,coin: _coin,time_period: _time_period)
    );
  }
}
class TransactionList extends StatelessWidget {
  String id;
  String coin="alpha";
  String time_period="";
  TransactionList({Key? key,required this.id,required this.time_period,required this.coin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionDetail>>(
      future: TransactionHttp.getTransactionHistory(id,type: coin,timePeriod: time_period,latest: true),
        builder: (context,snapshot){
            if(snapshot.data==null){
              return const Center(child: CircularProgressIndicator());
            }
            List<TransactionDetail> transactions=snapshot.data!;
            return ListView.builder(
              itemCount: snapshot.data?.length,
                itemBuilder:(context,index){
                    TransactionDetail transactionDetail=transactions[index];
                    return TransactionItem(
                        id: transactionDetail.id,
                        senderId: transactionDetail.senderId,
                        amount: transactionDetail.amount,
                        dateTime: transactionDetail.currentTimestamp
                    );
                }
            );
        }
    );
  }
}
class TransactionItem extends StatelessWidget {
  int id;
  String senderId;
  int amount;
  String dateTime;
   TransactionItem(
      {
        Key? key,
        required this.id,
        required this.senderId,
        required this.amount,
        required this.dateTime
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getDateStringInFormat(String date){
      DateTime dateTime=DateTime.parse(date);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute}";
    }
    return  Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.money),
            title: Text("Received $amount from $senderId"),
            subtitle: Text("Gotten at ${getDateStringInFormat(dateTime)} with id $id"),
          ),
        ],
      ),
    );
  }
}

