import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Datapage extends StatefulWidget {
  const Datapage({Key? key}) : super(key: key);

  @override
  State<Datapage> createState() => _DatapageState();
}

class _DatapageState extends State<Datapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(""
          // FirebaseFirestore.instance.c
        ),
      ),
    );
  }
}
