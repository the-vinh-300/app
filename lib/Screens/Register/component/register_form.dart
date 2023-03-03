import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Models/user.dart';
import 'package:demo_flutter/Screens/Index/index_screen.dart';
import 'package:demo_flutter/Screens/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterWiget extends StatefulWidget {
  const RegisterWiget({super.key});

  @override
  State<RegisterWiget> createState() => _RegisterWigetState();
}

class _RegisterWigetState extends State<RegisterWiget> {
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  final _formkey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          // Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        // Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = name.text;
    userModel.password = pass1.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    // Fluttertoast.showToast(msg: "Account created successfully :) ");

    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => const LoginScreen()),
    //     (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Icon(
        //   Icons.person,
        //   size: 70,
        // ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: TextFormField(
            controller: name,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Vui lòng nhập email");
              }
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person_outline_outlined,
                  color: Colors.black,
                ),
                hintText: 'Tên người dùng',
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: TextFormField(
            controller: email,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Vui lòng nhập email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Vui lòng nhập email hợp lệ");
              }
              return null;
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: TextFormField(
            controller: pass1,
            obscureText: true,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "Cần có mật khẩu để đăng nhập";
              }
              if (!regex.hasMatch(value)) {
                return "Nhập mật khẩu hợp lệ (Tối thiểu 6 ký tự)";
              }
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.password,
                  color: Colors.black,
                ),
                hintText: 'Mật khẩu',
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: TextFormField(
            controller: pass2,
            obscureText: true,
            validator: ((value) {
              if (pass2.text != pass1.text) {
                return "Mật khẩu không khớp!";
              }
              return null;
            }),
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.password_outlined,
                  color: Colors.black,
                ),
                hintText: 'Nhập lại mật khẩu',
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        InkWell(
            onTap: () async {
              // signUp(email.text, pass1.text);
              try {
                final newUser = _auth.createUserWithEmailAndPassword(
                    email: email.text, password: pass1.text);
                if (newUser != null) {
                  newUser.then((value) => postDetailsToFirestore());
                  final snackBar =
                      SnackBar(content: Text('Đăng ký thành công!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context, 'Đăng ký thành công!');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginScreen())));
                } else {
                  final snackBar = SnackBar(content: Text('Đăng ký thất bại!'));
                }
              } catch (e) {
                final snackBar = SnackBar(content: Text('Error'));
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => const LoginScreen())));
            },
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue),
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  // color: Colors.black,
                  height: 60,
                  child: const Center(
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
            )),
        // const SizedBox(
        //   height: 40,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Đã có tài khoản?',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginScreen())));
                },
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        )
      ],
    );
  }
}
