import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:demo_flutter/Component/var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ColChart extends StatefulWidget {
  String selectedDate;
  ColChart({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<ColChart> createState() => _ColChartState();
}

class _ColChartState extends State<ColChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 1 / 5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            // color: Colors.blue,
            // borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(70),
            //     bottomLeft: Radius.circular(70))
            borderRadius: BorderRadius.circular(30)),
        child: StreamBuilder<QuerySnapshot>(
          stream: details.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DateTime date = DateTime.now();
              // final url = details.where('date', isEqualTo: YearPicker);
              final day = date.day;
              final month = date.month;
              final year = date.year;
              int tolbal = 0;
              int tolinc = 0;
              int tolspe = 0;

              if (widget.selectedDate == 'Năm') {
                for (var doc in snapshot.data!.docs) {
                  DateTime _year = (doc['date'] as Timestamp).toDate();
                  if (_year.year == year) {
                    if (doc['name'] == 'Thu nhập') {
                      tolinc += (doc['money'] as int);
                    }
                    if (doc['name'] == 'Chi tiêu') {
                      tolspe += (doc['money'] as int);
                    }
                  }
                  tolbal = tolinc - tolspe;
                }
              }
              if (widget.selectedDate == 'Ngày') {
                for (var doc in snapshot.data!.docs) {
                  DateTime _day = (doc['date'] as Timestamp).toDate();
                  if (_day.day == day) {
                    if (doc['name'] == 'Thu nhập') {
                      tolinc += (doc['money'] as int);
                    }
                    if (doc['name'] == 'Chi tiêu') {
                      tolspe += (doc['money'] as int);
                    }
                  }
                  tolbal = tolinc - tolspe;
                }
              }
              if (widget.selectedDate == 'Tuần') {
                for (var doc in snapshot.data!.docs) {
                  DateTime week = (doc['date'] as Timestamp).toDate();
                  if (date.day - 7 <= week.day && week.day <= day) {
                    if (doc['name'] == 'Thu nhập') {
                      tolinc += (doc['money'] as int);
                    }
                    if (doc['name'] == 'Chi tiêu') {
                      tolspe += (doc['money'] as int);
                    }
                  }
                  tolbal = tolinc - tolspe;
                }
              }
              if (widget.selectedDate == 'Tháng') {
                for (var doc in snapshot.data!.docs) {
                  DateTime _month = (doc['date'] as Timestamp).toDate();
                  if (_month.month == month) {
                    if (doc['name'] == 'Thu nhập') {
                      tolinc += (doc['money'] as int);
                    }
                    if (doc['name'] == 'Chi tiêu') {
                      tolspe += (doc['money'] as int);
                    }
                  }
                  tolbal = tolinc - tolspe;
                }
              }

              if (tolinc + tolspe == 0) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Hãy cập nhật Thu / chi hiện tại của bạn!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator()
                    ]);
              } else {
                // ChartCol().increment(tolinc, tolspe);
                // return ChartCot(inc: tolinc, spe: tolspe);

                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartBarCustom(
                      showMeasureLabel: true,
                      showMeasureLine: true,
                      showDomainLabel: true,
                      showDomainLine: true,
                      // spaceBetweenItem: 10,
                      listData: [
                        DChartBarDataCustom(
                          value: 0,
                          label: "",
                        ),
                        DChartBarDataCustom(
                            value: tolinc.toDouble(),
                            label: "Thu nhập",
                            color: Colors.green),
                        DChartBarDataCustom(
                          value: 0,
                          label: "",
                        ),
                        DChartBarDataCustom(
                            value: tolspe.toDouble(),
                            label: "Chi tiêu",
                            color: Colors.red),
                        DChartBarDataCustom(
                          value: 0,
                          label: "",
                        ),
                      ]),
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}

class ChartCol extends GetxController {
  int inc = 0;
  int spe = 0;
  increment(int inl, int sp) {
    inc = inl;
    spe = sp;
  }
}

class ChartCot extends StatefulWidget {
  int inc;
  int spe;
  ChartCot({super.key, required this.inc, required this.spe});

  @override
  State<ChartCot> createState() => _ChartCotState();
}

class _ChartCotState extends State<ChartCot> {
  @override
  void initState() {
    // TODO: implement initState

    widget.inc;
    widget.spe;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setState(() {
      widget.inc;
      widget.spe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBarCustom(
          showMeasureLabel: true,
          showMeasureLine: true,
          showDomainLabel: true,
          showDomainLine: true,
          // spaceBetweenItem: 10,
          listData: [
            DChartBarDataCustom(
              value: 0,
              label: "",
            ),
            DChartBarDataCustom(
                value: widget.inc.toDouble(),
                label: "Thu nhập",
                color: Colors.green),
            DChartBarDataCustom(
              value: 0,
              label: "",
            ),
            DChartBarDataCustom(
                value: widget.spe.toDouble(),
                label: "Chi tiêu",
                color: Colors.red),
            DChartBarDataCustom(
              value: 0,
              label: "",
            ),
          ]),
    );
  }
}
