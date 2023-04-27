import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  var data;
  Homepage(this.data, {super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.data["username"]}"),
            Text("${widget.data["token"]}")
          ]),
    );
  }
}
