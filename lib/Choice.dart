import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:loginnode/Allproducts.dart';
import 'package:loginnode/addproduct.dart';

class Choice extends StatefulWidget {
  String? token;
  Choice(@required this.token, {super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Text(
                    'Select Operation',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  MaterialButton(
                    minWidth: 60.0,
                    height: 35,
                    color: Colors.blue,
                    child: new Text('ADD PRODUCTS',
                        style: new TextStyle(
                          fontSize: 16.0,
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Addproduct(widget.token)));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    minWidth: 60.0,
                    height: 35,
                    color: Colors.blue,
                    child: new Text('VIEW ALL PRODUCTS',
                        style: new TextStyle(
                          fontSize: 16.0,
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage2(widget.token)));
                    },
                  )
                ]))));
  }
}
