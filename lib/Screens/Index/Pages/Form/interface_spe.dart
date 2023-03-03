import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Component/object.dart';
import '../../../../Component/var.dart';
import '../component/chart.dart';

class StatisFormSpe extends StatefulWidget {
  const StatisFormSpe({super.key});

  @override
  State<StatisFormSpe> createState() => _StatisFormSpeState();
}

class _StatisFormSpeState extends State<StatisFormSpe> {
  List<DataItem> dataset = [];
  @override
  Widget build(BuildContext context) {
    //Data chart spending
    return StreamBuilder<QuerySnapshot>(
        stream: details.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int tol = 0;
            // final double all = 0.5;
            // final String name = '100%';
            // final Color _itemColor = Colors.red;
            final data = snapshot.data!.docs;
            String food = '';
            String cloth = '';
            String traffic = '';
            String house = '';
            String tourism = '';
            String bill = '';
            String insu = '';
            String tax = '';
            String gift = '';
            String ofther = '';

            int tolfo = 0;
            int tolclo = 0;
            int toltra = 0;
            int tolhou = 0;
            int toltou = 0;
            int tolbil = 0;
            int tolins = 0;
            int toltax = 0;
            int tolgif = 0;
            int toloth = 0;

            double tolfo1 = 0.0;
            double tolclo1 = 0.0;
            double toltra1 = 0.0;
            double tolhou1 = 0.0;
            double toltou1 = 0.0;
            double tolbil1 = 0.0;
            double tolins1 = 0.0;
            double toltax1 = 0.0;
            double tolgif1 = 0.0;
            double toloth1 = 0.0;

            // for (int i = 0; i < 8; i++) {
            //   val - 0.1;
            //   temp = val;

            //   // dataset = [DataItem(temp, name, _itemColor)];
            // }
            for (var docs in data) {
              if (docs['name'] == 'Chi tiêu') {
                tol += (docs['money'] as int);
                if (docs['type'] == 'Ăn uống') {
                  tolfo += (docs['money'] as int);
                  //food == 'Ăn uống';
                }
                if (docs['type'] == 'Quần áo') {
                  tolclo += (docs['money'] as int);
                  //cloth == 'Quần áo';
                }
                if (docs['type'] == 'Giao thông') {
                  toltra += (docs['money'] as int);
                  //traffic == 'Giao thông';
                }
                if (docs['type'] == 'Nhà ở') {
                  tolhou += (docs['money'] as int);
                  //house == 'Nhà ở';
                }
                if (docs['type'] == 'Du lịch') {
                  toltou += (docs['money'] as int);
                  //tourism == 'Du lịch';
                }
                if (docs['type'] == 'Chi phí điện nước') {
                  tolbil += (docs['money'] as int);
                  //bill == 'Điện nước';
                }
                if (docs['type'] == 'Bảo hiểm') {
                  tolins += (docs['money'] as int);
                  //insu == 'Bảo hiểm';
                }
                if (docs['type'] == 'Thuế') {
                  toltax += (docs['money'] as int);
                  //tax == 'Thuế';
                }
                if (docs['type'] == 'Quà') {
                  tolgif += (docs['money'] as int);
                  //gift == 'Quà';
                }
                if (docs['type'] == 'Khác') {
                  toloth += (docs['money'] as int);
                  //ofther == 'Khác';
                }
              }
              tolfo1 = tolfo / tol;
              tolclo1 = tolclo / tol;
              toltra1 = toltra / tol;
              tolhou1 = tolhou / tol;
              toltou1 = toltou / tol;
              tolbil1 = tolbil / tol;
              tolins1 = tolins / tol;
              toltax1 = toltax / tol;
              tolgif1 = tolgif / tol;
              toloth1 = toloth / tol;

              food = '${((tolfo1 * 100)).toStringAsFixed(1)}%';
              cloth = '${(tolclo1 * 100).toStringAsFixed(1)}%';
              traffic = '${(toltra1 * 100).toStringAsFixed(1)}%';
              house = '${(tolhou1 * 100).toStringAsFixed(1)}%';
              tourism = '${(toltou1 * 100).toStringAsFixed(1)}%';
              insu = '${(tolins1 * 100).toStringAsFixed(1)}%';
              bill = '${(tolbil1 * 100).toStringAsFixed(1)}%';
              tax = '${(toltax1 * 100).toStringAsFixed(1)}%';
              gift = '${(tolgif1 * 100).toStringAsFixed(1)}%';
              ofther = '${(toloth1 * 100).toStringAsFixed(1)}%';
            }
            // print(tolfo1);
            // if (tol == 0) {
            //   dataset = [DataItem(1, '100%', Colors.blueGrey)];
            // } else {

            dataset = [
              DataItem(tolfo1, food, Color.fromARGB(255, 23, 230, 30)),
              DataItem(tolclo1, cloth, Color.fromARGB(255, 179, 80, 45)),
              DataItem(toltra1, traffic, Color.fromARGB(255, 239, 182, 27)),
              DataItem(tolhou1, house, Colors.lightBlue),
              DataItem(toltou1, tourism, Colors.redAccent),
              DataItem(tolbil1, bill, Colors.deepPurpleAccent),
              DataItem(tolins1, insu, Colors.orangeAccent),
              DataItem(toltax1, tax, Colors.cyan),
              DataItem(tolgif1, gift, Colors.purple),
              DataItem(toloth1, ofther, Colors.grey),
            ];
            // }
            int w = 200;
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
                            color: Color.fromARGB(255, 23, 230, 30),
                            size: 35,
                          ),
                          title: const Text('Ăn uống'),
                          // subtitle: Row(
                          //   children: [
                          //     Container(
                          //       color: Colors.amber,
                          //       width: 200,
                          //       height: 10,
                          //     ),
                          //   ],
                          // ),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolfo),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Color.fromARGB(255, 179, 80, 45),
                            size: 35,
                          ),
                          title: Text('Quần áo'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolclo),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Color.fromARGB(255, 239, 182, 27),
                            size: 35,
                          ),
                          title: Text('Giao thông'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(toltra),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.lightBlue,
                            size: 35,
                          ),
                          title: Text('Nhà ở'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolhou),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.redAccent,
                            size: 35,
                          ),
                          title: Text('Du lịch'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(toltou),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.deepPurpleAccent,
                            size: 35,
                          ),
                          title: Text('Chi phí điện nước'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolbil),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.orangeAccent,
                            size: 35,
                          ),
                          title: Text('Bảo hiểm'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolins),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.cyan,
                            size: 35,
                          ),
                          title: Text('Thuế'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(toltax),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.square,
                            color: Colors.purple,
                            size: 35,
                          ),
                          title: Text('Quà'),
                          trailing: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(tolgif),
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
                                .format(toloth),
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
