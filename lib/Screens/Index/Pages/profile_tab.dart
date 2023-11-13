import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Component/function.dart';
import 'package:demo_flutter/Screens/Login/login_screen.dart';
import 'package:demo_flutter/Screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustom();
  }
}

class ProfileCustom extends StatefulWidget {
  const ProfileCustom({super.key});

  @override
  State<ProfileCustom> createState() => _ProfileCustomState();
}

class _ProfileCustomState extends State<ProfileCustom> {
  String? name = '';
  String? email = '';
  final _auth = FirebaseAuth.instance.currentUser!;
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
          // snapshot.data()!["password"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFormDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1 / 4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('img/banner.jpg'))),
              ),
              Positioned(
                top: 150,
                left: 20,
                child: avatarImg(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200, top: 20),
            child: Text(
              name!,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Chức năng',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Divider(
            // indent: 15,
            // endIndent: 15,
            height: 20,
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Tính năng đang được phát triển'),
                    );
                  });
            },
            leading: const Icon(
              Icons.settings,
              size: 40,
            ),
            title: const Text(
              'Cài đặt',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Tính năng đang được phát triển'),
                    );
                  });
            },
            leading: const Icon(
              Icons.notifications_active_outlined,
              size: 40,
            ),
            title: const Text(
              'Thông báo',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          const Text(
            'Thông tin tài khoản',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return const AlertDialog(
              //         content: Text('Tính năng đang được phát triển'),
              //       );
              //     });
            },
            leading: const Icon(
              Icons.email_outlined,
              size: 40,
            ),
            title: const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(email!),
          ),

          ListTile(
            onTap: () {
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return const AlertDialog(
              //         content: Text('Tính năng đang được phát triển'),
              //       );
              //     });
            },
            leading: const Icon(
              Icons.password_outlined,
              size: 40,
            ),
            title: const Text(
              'Mật khẩu',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('******'),
          ),

          // await FirebaseAuth.instance.signOut();
          // final snackBar = SnackBar(content: Text('Đã dăng xuất!'));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // Navigator.pop(context);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => LoginScreen())));
          ListTile(
            onTap: () {
              logout(context);
            },
            leading: const Icon(
              Icons.exit_to_app,
              size: 40,
            ),
            title: const Text(
              'Thoát',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  //Img avatar
  Widget avatarImg() => const CircleAvatar(
        maxRadius: 75,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          backgroundImage: AssetImage('img/avatar.gif'),
          maxRadius: 70,
        ),
      );
}
