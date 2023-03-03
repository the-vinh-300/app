import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/Models/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/welcome.dart';

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => WellcomeScreen()));
}
