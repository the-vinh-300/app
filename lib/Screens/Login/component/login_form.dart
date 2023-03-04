import 'package:demo_flutter/Models/login.dart';
import 'package:demo_flutter/Screens/Index/index_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              hintText: 'Nhập Email',
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: TextFormField(
            controller: pass,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.password,
                color: Colors.black,
              ),
              hintText: 'Nhập mật khẩu',
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              'Quên mật khẩu ?',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        InkWell(
            onTap: () async {
              try {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     });
                await _auth
                    .signInWithEmailAndPassword(
                        email: email.text, password: pass.text)
                    .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndexScreen())));
              } on FirebaseAuthException catch (error) {
                final snackBar = SnackBar(
                    content: Text('Email  hoặc mật khẩu không chính xác!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // switch (error.code) {
                //   case "invalid-email":
                //     errorMessage =
                //         "Your email address appears to be malformed.";
                //     break;
                //   case "wrong-password":
                //     errorMessage = "Your password is wrong.";
                //     break;
                //   case "user-not-found":
                //     errorMessage = "User with this email doesn't exist.";
                //     break;
                //   case "user-disabled":
                //     errorMessage = "User with this email has been disabled.";
                //     break;
                //   case "too-many-requests":
                //     errorMessage = "Too many requests";
                //     break;
                //   case "operation-not-allowed":
                //     errorMessage =
                //         "Signing in with Email and Password is not enabled.";
                //     break;
                //   default:
                //     errorMessage = "An undefined Error happened.";
                // }
              }
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
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
            ))
      ],
    );
  }
}
