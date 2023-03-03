import 'package:demo_flutter/Component/background.dart';
import 'package:demo_flutter/Screens/Login/component/login_form.dart';
import 'package:demo_flutter/Screens/Register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: h * 1.5 / 3,
          child: Column(
            children: [
              Container(
                height: h * 1 / 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('img/login.gif'))),
              ),
              Center(
                  child: Text(
                'Đăng nhập \n____[^.^]____'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ))
            ],
          ),
        ),
        Container(
          height: h * 1 / 3,
          padding: const EdgeInsets.all(10),
          child: const LoginWidget(),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Chưa có tài khoản?',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const RegisterScreen())));
                    },
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            )
          ],
        ))
      ],
    );
  }
}
