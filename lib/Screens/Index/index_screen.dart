import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Models/item.dart';
import 'package:demo_flutter/Models/login.dart';
import 'package:demo_flutter/Screens/Index/Pages/component/col_chart.dart';
import 'package:demo_flutter/Screens/Index/Pages/history_tab.dart';
import 'package:demo_flutter/Screens/Index/Pages/home_tab.dart';
import 'package:demo_flutter/Screens/Index/Pages/profile_tab.dart';
import 'package:demo_flutter/Screens/Index/Pages/statistical_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../Component/var.dart';

// class IndexScreen extends StatelessWidget {
//   IndexScreen({super.key});
//   final User? user = Login().currentUser;

//   Future<void> signOut() async {
//     await Login().signOut();
//   }

//   Widget _title() {
//     return const Text('data');
//   }

//   Widget _userUid() {
//     return Text(user?.email ?? 'User email');
//   }

//   Widget signOutButton() {
//     return ElevatedButton(
//         onPressed: (() {
//           signOut;
//         }),
//         child: const Text('Sign Out'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: signOutButton(),
//     );
//   }
// }

// class ItemInc {
//   List<String> item = [
//     'Cho thuê',
//     'Quyên góp',
//     'Tiền lương',
//     'Hoàn tiền',
//     'Bán hàng',
//     'Giải thưởng',
//     'Khác'
//   ];
//   List<Image> image = [
//     Image.asset('name'),
//     Image.asset('name'),
//     Image.asset('name'),
//     Image.asset('name'),
//     Image.asset('name'),
//     Image.asset('name'),
//   ];
//   ItemInc(this.item, this.image);
// }

// class ItemSpe {
//   String? label;
//   Image? image;
// }

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  // final List<ItemInc> inc = [];
  DateTime date = new DateTime.now();
  String? selectedMange;
  String? selectedType;
  List<String> provider = [];
  final List<String> _selectedMange = ['Thu nhập', 'Chi tiêu'];
  final List<String> _itemSpe = [
    'Ăn uống',
    'Quần áo',
    'Giao thông',
    'Nhà ở',
    'Du lịch',
    'Chi phí điện nước',
    'Bảo hiểm',
    'Thuế',
    'Quà',
    'Khác'
  ];

  final List<String> _itemInc = [
    'Cho thuê',
    'Quyên góp',
    'Tiền lương',
    'Hoàn tiền',
    'Bán hàng',
    'Giải thưởng',
    'Hỗ trợ',
    'Khác'
  ];

  int _selectedIndex = 0;
  void OntabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      HomeTab();
    });
  }

  final TextEditingController txtMoney = TextEditingController();
  final TextEditingController txtNote = TextEditingController();

  String? name = '';
  String? email = '';
  // String? pass = '';
  Future _getDataFormDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["name"];
          email = snapshot.data()!["email"];
          // pass = snapshot.data()!["password"];
        });
      }
    });
  }

  Future _postData() async {
    Item data = Item();
    data.name = selectedMange;
    data.type = selectedType;
    data.money = int.parse(txtMoney.text);
    data.date = date;
    data.note = txtNote.text;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('details')
        .doc()
        .set({
      'name': data.name,
      'type': data.type,
      'money': data.money,
      'date': data.date,
      'note': data.note
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      HomeTab;
      StatisTab;
    });

    _getDataFormDatabase();
  }

  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return const HomeTab();
      case 1:
        return const StatisTab();
      case 2:
        return const HistoryTab();
      case 3:
        return const ProfileTab();
      default:
        return const HomeTab();
    }
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildAppBarContent(int index) {
    switch (index) {
      case 0:
        return ListTile(
            leading: const Icon(
              Icons.person_outline,
              size: 50,
              color: Colors.black,
            ),
            title: Text(
              'Xin chào! ' + name!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: ((BuildContext context) {
                          return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              title: ListTile(
                                leading: const Text('Thêm thông tin',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                                trailing: TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      _postData();
                                      final snackBar = SnackBar(
                                          content: Text('Thêm thành công!'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Lưu',
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ),
                              content: StatefulBuilder(
                                  builder: ((BuildContext context, setState) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  // width: 100,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // Manage
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: Color(0xffC5C5C5),
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectedMange,
                                              items: _selectedMange.map((e) {
                                                return DropdownMenuItem<String>(
                                                    value: e,
                                                    child: Text('$e'));
                                              }).toList(),
                                              onChanged: ((value) {
                                                selectedType = null;
                                                provider = value == 'Thu nhập'
                                                    ? _itemInc
                                                    : _itemSpe;
                                                setState(() {
                                                  selectedMange = value;
                                                });
                                              }),
                                              hint: const Text(
                                                  'Thu nhập / Chi tiêu'),
                                            )),
                                        //Spend Income
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: Color(0xffC5C5C5),
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectedType,
                                              items: provider.map((e) {
                                                return DropdownMenuItem<String>(
                                                    value: e,
                                                    child: Text('$e'));
                                              }).toList(),
                                              onChanged: ((value) {
                                                setState(() {
                                                  selectedType = value;
                                                });
                                              }),
                                              hint: const Text(
                                                  'Loại chi tiêu / thu nhập'),
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          child: TextFormField(
                                            controller: txtMoney,
                                            keyboardType: TextInputType.number,
                                            validator: ((value) {
                                              if (value!.isEmpty) {
                                                return "Nhập số tiền";
                                              }
                                            }),
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons
                                                      .monetization_on_outlined,
                                                  color: Colors.black,
                                                ),
                                                hintText: 'Nhập số tiền',
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                suffixText: 'VNĐ'),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        date_time(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          child: TextFormField(
                                            controller: txtNote,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              hintText: 'Ghi chú',
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })));
                        }));
                  });
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                )));
      case 1:
        return const Text(
          'Thống kê',
          style: TextStyle(color: Colors.black),
        );
      case 2:
        return const ListTile(
          title: Text(
            'Thay đổi thông tin thu / chi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // style: TextStyle(color: Colors.white),
          ),
        );
      case 3:
        return const Text(
          'Tài khoản',
          style: TextStyle(color: Colors.black),
        );
      default:
        return const ListTile(
          title: Text(
            'Xin chào',
            // style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.notifications_active_outlined,
            // color: Colors.white,
          ),
        );
    }
  }

  // List<Widget> lsScreen = [Text('data'), Text('dat1')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildAppBarContent(_selectedIndex),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: OntabSelected,
        selectedItemColor: Colors.blue,
        // backgroundColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: 'Thống kê'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notes_outlined), label: 'Kế hoạch'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Tài khoản'),
        ],
      ),
      body: buildTabContent(_selectedIndex),
    );
  }
}
