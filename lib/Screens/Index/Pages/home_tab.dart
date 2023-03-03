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
                    if (docs['name'] == 'Thu nhập') {
                      tolinc += (docs['money'] as int);
                    }
                    if (docs['name'] == 'Chi tiêu') {
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
                                  'Tổng số dư',
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
                                            'Hướng dẫn'.toUpperCase(),
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
                                                        'Tổng quát',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        'Ứng dụng gồm 4 trang hỗ trợ cho mỗi người dùng thao tác và quản lí được thu chi của bản thân. Gồm có: Trang chủ, Trang thống kê, Trang thay đổi thông tin thu chi, Trang tài khoản.',
                                                        // style: TextStyle(
                                                        //     color: Colors.blue),
                                                      ),
                                                      Text(
                                                        'Trang chủ',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'Dấu + ở góc phải trên cùng màn hình dung để thêm thông tin khoản thu hoặc chi của người dùng. Thông tin được lưu sẽ được hiển thị ở mục lịch sử trên Trang chủ, người dùng có thể vuốt sang trái hoặc phải để xóa thông tin khoản thu hoặc chi vừa nhập.'),
                                                      Text(
                                                        'Trang thống kê',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'Mục đầu tiên thông kê tổng số khoản chi tiêu của từng thông tin, mục thứ 2 là thông kê khoản thu. Để sang mục thứ 2 cần phải vuốt màn hình từ phải sang trái và ngược lại.'),
                                                      Text(
                                                        'Trang thay đổi thông tin thu chi',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'Trang hiển thị các thông tin khoản thu chi mà người dùng đã thêm ở Trang chủ nhấn vào 1 thông tin mà người dùng cần thay đổi và chọn sửa.'),
                                                      Text(
                                                          'Lưu ý: Người dùng chỉ có thể thay đổi số tiền, ngày lưu và phần ghi chú.'),
                                                      Text(
                                                        'Trang tài khoản',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          'Hiển thị thông tin tài khoản của người dùng, có thể cập nhật lại thông tin cá nhân.')
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
                              'Thu nhập',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Chi tiêu',
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
                'Lịch sử',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                'Xem tất cả',
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
                    if (data['type'] == 'Ăn uống') {
                      name = food;
                    }
                    if (data['type'] == 'Quần áo') {
                      name = clothe;
                    }
                    if (data['type'] == 'Giao thông') {
                      name = traffic;
                    }
                    if (data['type'] == 'Nhà ở') {
                      name = house;
                    }
                    if (data['type'] == 'Du lịch') {
                      name = tourism;
                    }
                    if (data['type'] == 'Chi phí điện nước') {
                      name = bill;
                    }
                    if (data['type'] == 'Bảo hiểm') {
                      name = insu;
                    }
                    if (data['type'] == 'Thuế') {
                      name = tax;
                    }
                    if (data['type'] == 'Quà') {
                      name = gif;
                    }
                    if (data['type'] == 'Khác') {
                      name = other;
                    }
                    if (data['type'] == 'Cho thuê') {
                      name = rent;
                    }
                    if (data['type'] == 'Quyên góp') {
                      name = donation;
                    }
                    if (data['type'] == 'Tiền lương') {
                      name = salary;
                    }
                    if (data['type'] == 'Hoàn tiền') {
                      name = money;
                    }
                    if (data['type'] == 'Bán hàng') {
                      name = sell;
                    }
                    if (data['type'] == 'Giải thưởng') {
                      name = prize;
                    }
                    if (data['type'] == 'Hỗ trợ') {
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
                          // data['money'].toString() + 'đ',
                          NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
                              .format(data['money']),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: data['name'] == 'Thu nhập'
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
