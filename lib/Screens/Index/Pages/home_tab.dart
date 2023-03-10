import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Component/function.dart';
import 'package:demo_flutter/Component/var.dart';
import 'package:demo_flutter/Models/item.dart';
import 'package:demo_flutter/Screens/Index/Pages/Form/main_home.dart';
import 'package:demo_flutter/Screens/Index/Pages/component/col_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeCustom();
  }
}

class HomeCustom extends StatefulWidget {
  const HomeCustom({super.key});

  @override
  State<HomeCustom> createState() => _HomeCustomState();
}

class _HomeCustomState extends State<HomeCustom> {
  // Future _getData() async {
  //   await FirebaseFirestore.instance
  //       .collection('totals')
  //       .doc(user!.uid)
  //       .set(Finance().toMap());
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getDataFormDatabase();
    // _getData();
  }

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        // Stack(
        //   clipBehavior: Clip.none,
        //   children: [
        // Column(
        //   children: [
        // Container(
        //   height: MediaQuery.of(context).size.height * 1 / 10,
        // ),
        Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 1 / 6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue,
                // borderRadius: BorderRadius.only(
                //     bottomRight: Radius.circular(70),
                //     bottomLeft: Radius.circular(70))
                borderRadius: BorderRadius.circular(30)),
            child: StreamBuilder<QuerySnapshot>(
              stream: details.snapshots(),
              builder: (context, snapshot) {
                //banner home
                if (snapshot.hasData) {
                  int tolbal = 0;
                  int tolinc = 0;
                  int tolspe = 0;
                  for (var docs in snapshot.data!.docs) {
                    if (docs['name'] == 'Thu nh???p') {
                      tolinc += (docs['money'] as int);
                    }
                    if (docs['name'] == 'Chi ti??u') {
                      tolspe += (docs['money'] as int);
                    }
                    tolbal = tolinc - tolspe;
                  }

                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'T???ng s??? d??',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'vi-VN', decimalDigits: 0)
                                      .format(tolbal),
                                  // tolbal.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(
                                              child: Text(
                                            'H?????ng d???n'.toUpperCase(),
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                          content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        'T???ng qu??t',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        '???ng d???ng g???m 4 trang h??? tr??? cho m???i ng?????i d??ng thao t??c v?? qu???n l?? ???????c thu chi c???a b???n th??n. G???m c??: Trang ch???, Trang th???ng k??, Trang thay ?????i th??ng tin thu chi, Trang t??i kho???n.',
                                                        // style: TextStyle(
                                                        //     color: Colors.blue),
                                                      ),
                                                      Text(
                                                        'Trang ch???',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'D???u + ??? g??c ph???i tr??n c??ng m??n h??nh dung ????? th??m th??ng tin kho???n thu ho???c chi c???a ng?????i d??ng. Th??ng tin ???????c l??u s??? ???????c hi???n th??? ??? m???c l???ch s??? tr??n Trang ch???, ng?????i d??ng c?? th??? vu???t sang tr??i ho???c ph???i ????? x??a th??ng tin kho???n thu ho???c chi v???a nh???p.'),
                                                      Text(
                                                        'Trang th???ng k??',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'M???c ?????u ti??n th??ng k?? t???ng s??? kho???n chi ti??u c???a t???ng th??ng tin, m???c th??? 2 l?? th??ng k?? kho???n thu. ????? sang m???c th??? 2 c???n ph???i vu???t m??n h??nh t??? ph???i sang tr??i v?? ng?????c l???i.'),
                                                      Text(
                                                        'Trang thay ?????i th??ng tin thu chi',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'Trang hi???n th??? c??c th??ng tin kho???n thu chi m?? ng?????i d??ng ???? th??m ??? Trang ch??? nh???n v??o 1 th??ng tin m?? ng?????i d??ng c???n thay ?????i v?? ch???n s???a.'),
                                                      Text(
                                                          'L??u ??: Ng?????i d??ng ch??? c?? th??? thay ?????i s??? ti???n, ng??y l??u v?? ph???n ghi ch??.'),
                                                      Text(
                                                        'Trang t??i kho???n',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'Hi???n th??? th??ng tin t??i kho???n c???a ng?????i d??ng, c?? th??? c???p nh???t l???i th??ng tin c?? nh??n.')
                                                    ]),
                                              )),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 30,
                                ))
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Thu nh???p',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Chi ti??u',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              NumberFormat.simpleCurrency(
                                      locale: 'vi-VN', decimalDigits: 0)
                                  .format(tolinc),
                              // tolinc.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              NumberFormat.simpleCurrency(
                                      locale: 'vi-VN', decimalDigits: 0)
                                  .format(tolspe),
                              // tolspe.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ]);
                }
                return const CircularProgressIndicator();
              },
            )),
        //   ],
        // ),
        // Positioned(
        //     left: 40,
        //     bottom: 80,
        //     child: Container(
        //       height: MediaQuery.of(context).size.height * 1 / 4,
        //       width: MediaQuery.of(context).size.width / 2,
        //       decoration: const BoxDecoration(
        //           image: DecorationImage(image: AssetImage('img/login.gif'))),
        //     )),
        //   ],
        // ),

        //Main
        const HomeMain(),

        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'L???ch s???',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                'Xem t???t c???',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const Divider(
          indent: 15,
          endIndent: 15,
          height: 20,
          thickness: 2,
          color: Colors.black,
        ),
        Expanded(child: ShowData())
      ]),
    );
  }
}

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  final user = FirebaseAuth.instance.currentUser;
  Future _deleteItem(id) async {
    // await _item.doc(pid).delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('details')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .collection('details')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String name = '';

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final DocumentSnapshot data = snapshot.data!.docs[index];
                    Timestamp t = data['date'] as Timestamp;
                    DateTime dt = t.toDate();
                    if (data['type'] == '??n u???ng') {
                      name = food;
                    }
                    if (data['type'] == 'Qu???n ??o') {
                      name = clothe;
                    }
                    if (data['type'] == 'Giao th??ng') {
                      name = traffic;
                    }
                    if (data['type'] == 'Nh?? ???') {
                      name = house;
                    }
                    if (data['type'] == 'Du l???ch') {
                      name = tourism;
                    }
                    if (data['type'] == 'Chi ph?? ??i???n n?????c') {
                      name = bill;
                    }
                    if (data['type'] == 'B???o hi???m') {
                      name = insu;
                    }
                    if (data['type'] == 'Thu???') {
                      name = tax;
                    }
                    if (data['type'] == 'Qu??') {
                      name = gif;
                    }
                    if (data['type'] == 'Kh??c') {
                      name = other;
                    }
                    if (data['type'] == 'Cho thu??') {
                      name = rent;
                    }
                    if (data['type'] == 'Quy??n g??p') {
                      name = donation;
                    }
                    if (data['type'] == 'Ti???n l????ng') {
                      name = salary;
                    }
                    if (data['type'] == 'Ho??n ti???n') {
                      name = money;
                    }
                    if (data['type'] == 'B??n h??ng') {
                      name = sell;
                    }
                    if (data['type'] == 'Gi???i th?????ng') {
                      name = prize;
                    }
                    if (data['type'] == 'H??? tr???') {
                      name = sp;
                    }
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        _deleteItem(data.id);
                      },
                      child: ListTile(
                        leading: Image.asset(name),
                        title: Text(
                          data['type'].toString(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${dt.day}/${dt.month}/${dt.year}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Text(
                          // data['money'].toString() + '??',
                          NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
                              .format(data['money']),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: data['name'] == 'Thu nh???p'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
