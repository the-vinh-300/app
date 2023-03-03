import 'package:demo_flutter/Component/background.dart';
import 'package:demo_flutter/Screens/Register/component/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: RegisterForm());
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Đăng ký'.toUpperCase(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            // const Icon(
            //   Icons.person,
            //   size: 200,
            // ),
            Container(
              height: MediaQuery.of(context).size.height * 1.1 / 4,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('img/signup.gif'))),
            )
          ],
        )),
        // const Icon(
        //   Icons.person,
        //   size: 70,
        // ),
        Container(
          padding: const EdgeInsets.all(20),
          height: h * 2.2 / 4,
          child: RegisterWiget(),
        ),
      ],
    );
  }
}
