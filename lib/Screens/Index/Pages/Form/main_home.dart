import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Component/var.dart';
import 'package:demo_flutter/Screens/Index/Pages/component/col_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class selectedValue extends GetxController {
  String? date;
  setValue(value) {
    date = value;
  }
}

class _HomeMainState extends State<HomeMain> {
  String? date;
  final List<String> _date = ['Ngày', 'Tuần', 'Tháng', 'Năm'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = _date[3];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: details.snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Biểu đồ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: date,
                    items: _date.map((e) {
                      return DropdownMenuItem<String>(
                          value: e, child: Text('$e'));
                    }).toList(),
                    onChanged: ((value) {
                      setState(() {
                        date = value;
                        selectedValue().setValue(value);
                      });
                    }),
                    // hint: const Text('Ngày/ Tuần/ Tháng/ Năm'),
                  ),
                ],
              ),
              ColChart(selectedDate: date.toString()),
            ],
          );
        });
  }
}
