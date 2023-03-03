import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? name;
  String? type;
  int? money;
  DateTime? date;
  String? note;

  Item({this.name, this.type, this.money, this.date, this.note});

  factory Item.fromMap(map) {
    return Item(
      name: map['name'],
      type: map['type'],
      money: map['money'],
      date: (map['date'] as Timestamp).toDate(),
      note: map['note'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'money': money,
      'date': date,
      'note': note
    };
  }
}
