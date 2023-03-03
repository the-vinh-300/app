import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              // image: DecorationImage(image: AssetImage('assetName'))
              ),
          child: SafeArea(
            child: child,
          )),
    );
  }
}
