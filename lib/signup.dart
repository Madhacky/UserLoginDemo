import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:loginnode/home.dart';
import 'package:loginnode/Allproducts.dart';
import 'package:loginnode/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _role = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Center(
          child: Card(
            elevation: 20,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Explore Me\nSign Up',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                        ),
//                        Name box
                        Container(
                          child: TextFormField(
                            controller: _name,
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
//                      email
                        Container(
                          child: TextFormField(
                            controller: _username,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(30)),
                                contentPadding: EdgeInsets.all(15),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: Colors.blue,
                                focusColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30)),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'E-mail'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
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
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _role,
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
                                  Icons.person_2_rounded,
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: Colors.blue,
                                focusColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30)),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Role'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
//                    button
                        MaterialButton(
                            padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30),
                            ),
                            onPressed: () async {
                              await SignupApi();
                            },
                            child: Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
//                      redirect to signup page
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var data;
  SignupApi() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "username": "${_name.text}",
      "password": "${_password.text}",
      "email": "${_username.text}",
      "phone": 9000900000,
      "userType": "${_role.text}"
    });
    var response = await post(
      Uri.parse('https://usermanage-3ydh.onrender.com/user/signup'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      if (data['status'] == 'Registered Sucessfully') {
        Fluttertoast.showToast(
            msg: "Registered Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      print(response.body);
    } else {
      print(response.reasonPhrase);
    }

    return response;
  }
}
