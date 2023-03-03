import 'package:demo_flutter/Component/background.dart';
import 'package:demo_flutter/Screens/Google/sign_in.dart';
import 'package:demo_flutter/Screens/Index/index_screen.dart';
import 'package:demo_flutter/Screens/Login/login_screen.dart';
import 'package:demo_flutter/Screens/Register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: WellComeForm());
  }
}

class WellComeForm extends StatefulWidget {
  const WellComeForm({super.key});

  @override
  State<WellComeForm> createState() => _WellComeFormState();
}

class _WellComeFormState extends State<WellComeForm> {
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: h / 2,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('img/welcome.gif'))),
        ),
        Text(
          'Quản lý chi tiêu'.toUpperCase(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.blue),
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: const Center(
                child: Text(
              'Đăng nhập',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ));
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.blue),
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: const Center(
                child: Text(
              'Đăng ký',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        const SizedBox(
          child: Text(
            '--Hoặc đăng nhập với--',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            final provider =
                Provider.of<GoogleSignProvider>(context, listen: false);
            provider.googleLogin();
          },
          child: Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.blue),
              width: MediaQuery.of(context).size.width * 2 / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('img/icon/google.png'),
                  ),
                  const Text(
                    'Google',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 50,
                  )
                ],
              )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1 / 2,
        )
      ],
    );
  }
}
