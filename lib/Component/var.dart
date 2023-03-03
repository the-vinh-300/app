import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser;
final details = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('details');

String food = 'img/icon/food.png';
String clothe = 'img/icon/clothe.png';
String traffic = 'img/icon/traffic.png';
String house = 'img/icon/house.png';
String tourism = 'img/icon/tourism.png';
String bill = 'img/icon/bill.png';
String insu = 'img/icon/insurance.png';
String tax = 'img/icon/tax.jpg';
String gif = 'img/icon/gift.png';
String other = 'img/icon/other.png';

String rent = 'img/icon/rent.png';
String salary = 'img/icon/salary.png';
String donation = 'img/icon/donation.png';
String money = 'img/icon/money.png';
String sell = 'img/icon/sell.png';
String prize = 'img/icon/prize.png';
String sp = 'img/icon/sp.png';



// DateTime date = new DateTime.now();
// String? selectedMange;
// String? selectedType;
// List<String> provider = [];
// final List<String> _selectedMange = ['Thu nhập', 'Chi tiêu'];
// final List<String> _itemSpe = [
//   'Ăn uống',
//   'Quần áo',
//   'Giao thông',
//   'Nhà ở',
//   'Du lịch',
//   'Chi phí điện nước',
//   'Bảo hiểm',
//   'Thuế',
//   'Quà',
//   'Khác'
// ];
// final List<String> _imgSpe = [
//   'img/icon/food.png',
//   'img/icon/clothe.png',
//   'img/icon/traffic.png',
//   'img/icon/house.png',
//   'img/icon/tourism.png',
//   'img/icon/bill.png',
//   'img/icon/insurance.png',
//   'img/icon/tax.jpg',
//   'img/icon/gift.png',
//   'img/icon/other.png',
// ];
// final List<String> _itemInc = [
//   'Cho thuê',
//   'Quyên góp',
//   'Tiền lương',
//   'Hoàn tiền',
//   'Bán hàng',
//   'Giải thưởng',
//   'Hỗ trợ',
//   'Khác'
// ];
// final List<String> _imgInc = [
//   'img/icon/rent.png',
//   'img/icon/salary.png',
//   'img/icon/donations.png',
//   'img/icon/money.jpg',
//   'img/icon/sell.png',
//   'img/icon/prize.png',
//   'img/icon/other.png',
// ];

// listcate(time) async {
//   final user = FirebaseAuth.instance.currentUser;
//   final details = FirebaseFirestore.instance
//       .collection('users')
//       .doc(user!.uid)
//       .collection('details')
//       .where('date', isEqualTo: time);
// }
