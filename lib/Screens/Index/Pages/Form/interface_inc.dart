import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../../../Component/object.dart';
import '../../../../Component/var.dart';
import '../component/chart.dart';

class StatisFormInc extends StatefulWidget {
  const StatisFormInc({super.key});

  @override
  State<StatisFormInc> createState() => _StatisFormIncState();
}

class _StatisFormIncState extends State<StatisFormInc> {
  List<DataItem> dataset = [];
  @override
  Widget build(BuildContext context) {
    //data chart income
    return StreamBuilder<QuerySnapshot>(
        stream: details.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int tol = 0;
            // final double all = 0.5;
            // final String name = '100%';
            // final Color _itemColor = Colors.red;
            final data = snapshot.data!.docs;
            String rent = '';
            String donation = '';
            String salary = '';
            String refund = '';
            String sell = '';
            String prize = '';
            String suppo = '';
            String other = '';

            int tolrent = 0;
            int toldona = 0;
            int tolsala = 0;
            int tolrefu = 0;
            int tolsell = 0;
            int tolpriz = 0;
            int tolsupp = 0;
            int tolother = 0;

            double tolrent1 = 0.0;
            double toldona1 = 0.0;
            double tolsala1 = 0.0;
            double tolrefu1 = 0.0;
            double tolsell1 = 0.0;
            double tolpriz1 = 0.0;
            double tolsupp1 = 0.0;
            double tolother1 = 0.0;

            // for (int i = 0; i < 8; i++) {
            //   val - 0.1;
            //   temp = val;

            //   // dataset = [DataItem(temp, name, _itemColor)];
            // }
            for (var docs in data) {
              if (docs['name'] == 'Thu nhập') {
                tol += (docs['money'] as int);
                if (docs['type'] == 'Cho thuê') {
                  tolrent += (docs['money'] as int);
                }
                if (docs['type'] == 'Quyên góp') {
                  toldona += (docs['money'] as int);
                }
                if (docs['type'] == 'Tiền lương') {
                  tolsala += (docs['money'] as int);
                }
                if (docs['type'] == 'Hoàn tiền') {
                  tolrefu += (docs['money'] as int);
                }
                if (docs['type'] == 'Bán hàng') {
                  tolsell += (docs['money'] as int);
                }
                if (docs['type'] == 'Giải thưởng') {
                  tolpriz += (docs['money'] as int);
                }
                if (docs['type'] == 'Hỗ trợ') {
                  tolsupp += (docs['money'] as int);
                }
                if (docs['type'] == 'Khác') {
                  tolother += (docs['money'] as int);
                }
              }
              tolrent1 = tolrent / tol;
              toldona1 = toldona / tol;
              tolsala1 = tolsala / tol;
              tolrefu1 = tolrefu / tol;
              tolsell1 = tolsell / tol;
              tolpriz1 = tolpriz / tol;
              tolsupp1 = tolsupp / tol;
              tolother1 = tolother / tol;

              rent = '${((tolrent1 * 100)).toStringAsFixed(1)}%';
              donation = '${(toldona1 * 100).toStringAsFixed(1)}%';
              salary = '${(tolsala1 * 100).toStringAsFixed(1)}%';
              refund = '${(tolrefu1 * 100).toStringAsFixed(1)}%';
              sell = '${(tolsell1 * 100).toStringAsFixed(1)}%';
              prize = '${(tolpriz1 * 100).toStringAsFixed(1)}%';
              suppo = '${(tolsupp1 * 100).toStringAsFixed(1)}%';
              other = '${(tolother1 * 100).toStringAsFixed(1)}%';
            }

            dataset = [
              DataItem(tolrent1, rent, Colors.green),
              DataItem(toldona1, donation, Color.fromARGB(255, 179, 80, 45)),
              DataItem(tolsala1, salary, Color.fromARGB(255, 239, 182, 27)),
              DataItem(tolrefu1, refund, Colors.lightBlue),
              DataItem(tolsell1, sell, Colors.redAccent),
              DataItem(tolpriz1, prize, Colors.deepPurpleAccent),
              DataItem(tolsupp1, suppo, Colors.orangeAccent),
              DataItem(tolother1, other, Colors.grey),
            ];
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 8,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 1 / 4,
                    child: Chart(dataset)),
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 8,
                ),
                const Text(
                  'Ghi chú',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.green,
                            size: 35,
                          ),
                          title: const Text('Cho thuê'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolrent),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Color.fromARGB(255, 179, 80, 45),
                            size: 35,
                          ),
                          title: Text('Quyên góp'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(toldona),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Color.fromARGB(255, 239, 182, 27),
                            size: 35,
                          ),
                          title: Text('Tiền lương'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolsala),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.lightBlue,
                            size: 35,
                          ),
                          title: Text('Hoàn tiền'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolrefu),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.redAccent,
                            size: 35,
                          ),
                          title: Text('Bán hàng'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolsell),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.deepPurpleAccent,
                            size: 35,
                          ),
                          title: Text('Giải thưởng'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolpriz),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.orangeAccent,
                            size: 35,
                          ),
                          title: Text('Hỗ trợ'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolsupp),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.grey,
                            size: 35,
                          ),
                          title: Text('Khác'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolother),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
