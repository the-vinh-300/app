import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Component/var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../../Models/item.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return HistoryCustom();
  }
}

class HistoryCustom extends StatefulWidget {
  const HistoryCustom({super.key});

  @override
  State<HistoryCustom> createState() => _HistoryCustomState();
}

class _HistoryCustomState extends State<HistoryCustom> {
  DateTime date = new DateTime.now();
  final TextEditingController txtManage = TextEditingController();
  final TextEditingController txtItem = TextEditingController();
  final TextEditingController txtMoney = TextEditingController();
  final TextEditingController txtNote = TextEditingController();
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

  Future<void> updateItem(id) async {
    Item data = Item();
    // data.name = selectedMange;
    // data.type = selectedType;
    data.money = int.parse(txtMoney.text);
    data.date = date;
    data.note = txtNote.text;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('details')
        .doc(id)
        .update({
      // 'name': data.name,
      // 'type': data.type,
      'money': data.money,
      'date': data.date,
      'note': data.note
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1 / 3.5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('img/history.gif'))),
        ),
        Text(
          'Lịch sử Thu / Chi'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: details.snapshots(),
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
                    return ListTile(
                      leading: Image.asset(name),
                      title: Text(
                        data['type'].toString(),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['note'].toString(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${dt.day}/${dt.month}/${dt.year}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple),
                          ),
                        ],
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
                      onTap: () {
                        txtManage.text = data['name'].toString();
                        txtItem.text = data['type'].toString();
                        txtMoney.text = data['money'].toString();
                        txtNote.text = data['note'].toString();
                        showDialog(
                            context: context,
                            builder: ((BuildContext context) {
                              return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  title: ListTile(
                                    leading: const Text('Thông tin ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                    trailing: TextButton(
                                        onPressed: () {
                                          setState(() {});
                                          updateItem(data.id);
                                          final snackBar = SnackBar(
                                              content: Text('Sửa thành công!'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Sửa',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ),
                                  content: StatefulBuilder(builder:
                                      ((BuildContext context, setState) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      // width: 100,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            // Manage

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
                                                enabled: false,
                                                controller: txtManage,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                    Icons
                                                        .insert_invitation_outlined,
                                                    size: 35,
                                                    color: Colors.deepPurple,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                              ),
                                            ),

                                            // Container(
                                            //     padding:
                                            //         const EdgeInsets.symmetric(
                                            //             horizontal: 15),
                                            //     width: 300,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius.circular(10),
                                            //       border: Border.all(
                                            //         width: 2,
                                            //         color: Color(0xffC5C5C5),
                                            //       ),
                                            //     ),
                                            //     child: DropdownButton<String>(
                                            //       isExpanded: true,
                                            //       value: selectedMange =
                                            //           data['name'],
                                            //       items:
                                            //           _selectedMange.map((e) {
                                            //         return DropdownMenuItem<
                                            //                 String>(
                                            //             enabled: false,
                                            //             value: e,
                                            //             child: Text('$e'));
                                            //       }).toList(),
                                            //       onChanged: ((value) {
                                            //         selectedType = null;
                                            //         // provider =
                                            //         //     value == 'Thu nhập'
                                            //         //         ? _itemInc
                                            //         //         : _itemSpe;
                                            //         setState(() {
                                            //           // data['name'];
                                            //           selectedMange = value;
                                            //         });
                                            //       }),
                                            //       hint: const Text(
                                            //           'Thu nhập / Chi tiêu'),
                                            //     )),

                                            //Spend Income
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
                                                enabled: false,
                                                controller: txtItem,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                    Icons.interests_outlined,
                                                    size: 35,
                                                    color: Colors.green,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                              ),
                                            ),

                                            // Container(
                                            //     padding:
                                            //         const EdgeInsets.symmetric(
                                            //             horizontal: 15),
                                            //     width: 300,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius.circular(10),
                                            //       border: Border.all(
                                            //         width: 2,
                                            //         color: Color(0xffC5C5C5),
                                            //       ),
                                            //     ),
                                            //     child: DropdownButton<String>(
                                            //       isExpanded: true,
                                            //       value: selectedType =
                                            //           data['type'],
                                            //       items: provider.map((e) {
                                            //         return DropdownMenuItem<
                                            //                 String>(
                                            //             value: e,
                                            //             child: Text('$e'));
                                            //       }).toList(),
                                            //       onChanged: ((value) {
                                            //         setState(() {
                                            //           selectedType = value;
                                            //         });
                                            //       }),
                                            //       hint: const Text(
                                            //           'Loại chi tiêu / thu nhập'),
                                            //     )),

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
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: ((value) {
                                                  if (value!.isEmpty) {
                                                    return "Nhập số tiền";
                                                  }
                                                }),
                                                decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      size: 35,
                                                      color: Colors.yellow,
                                                    ),
                                                    hintText: 'Nhập số tiền',
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
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
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                      },
                    );
                  }));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            return CircularProgressIndicator();
          },
        ))
      ],
    );
  }
}
