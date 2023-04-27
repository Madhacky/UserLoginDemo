import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:loginnode/Choice.dart';
import 'package:loginnode/addproduct.dart';
import 'package:loginnode/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        title: Text('Sign In'),
//      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Center(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Hello User',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        // E-mail TextField
                        Container(
                          child: TextFormField(
                            controller: _username,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(30)),
                                contentPadding: EdgeInsets.all(15),
                                suffixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: Colors.blue,
                                focusColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30)),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Username'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        // Password TextField
                        Container(
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(30)),
                                contentPadding: EdgeInsets.all(15),
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: Colors.blue,
                                focusColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30)),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Passwod'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60),
                        ),
                        //  Sign In button
                        MaterialButton(
                            padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30),
                            ),
                            onPressed: () {
                              LoginApi();
                            },
                            child: Text(
                              'Log In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
            elevation: 20,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150),
            )),
          ),
        ),
      ),
    );
  }

  var data;
  LoginApi() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode(
        {"username": "${_username.text}", "password": "${_password.text}"});
    var response = await post(
      Uri.parse('https://usermanage-3ydh.onrender.com/user/login'),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      // if (data == 'Unauthorized') {
      // } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Choice(data['token'])));
      // }
      print(response.body);
    } else if (response.statusCode == 401) {
      data = json.decode(response.body);
      if (data['message'] == 'User does not exists!!') {
        Fluttertoast.showToast(
            msg: "${data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (data['message'] == 'Incorrect Password') {
        Fluttertoast.showToast(
            msg: "${data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Server Down",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return response;
  }
}
