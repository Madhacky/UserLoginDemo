import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loginnode/home.dart';
import 'package:loginnode/Allproducts.dart';

class Addproduct extends StatefulWidget {
  String? token;
  Addproduct(@required this.token, {super.key});
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  bool option = false;
  @override
  void initState() {
    print(widget.token);
    // TODO: implement initState
    super.initState();
  }

  TextEditingController _productname = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _rating = TextEditingController();
  File? image;
  String base64Image = '';
  List<int> imageBytes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Center(
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 20,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                )),
                child: Column(
                  children: <Widget>[
                    Text(
                      'ADD PRODUCTS',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        child: Column(
                          children: <Widget>[
//                        Name box
                            Container(
                              child: TextFormField(
                                controller: _productname,
                                maxLength: 10,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Product Name'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
//                      email
                            Container(
                              child: TextFormField(
                                controller: _quantity,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Quantity'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _rating,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Rating'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),

                            Container(
                              child: TextFormField(
                                maxLines: 4,
                                controller: _description,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.blue,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Description'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                    color: Colors.blue,
                                    child: const Text("Pick Image from Gallery",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () async {
                                      setState(() {
                                        option = false;
                                      });
                                      try {
                                        final image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (image == null) return;
                                        final imageTemp = File(
                                          image.path,
                                        );
                                        setState(() {
                                          this.image = imageTemp;
                                          imageBytes =
                                              imageTemp.readAsBytesSync();
                                          base64Image =
                                              base64Encode(imageBytes);
                                        });
                                      } on PlatformException catch (e) {
                                        print('Failed to pick image: $e');
                                      }
                                    }),
                                option == false
                                    ? base64Image == ''
                                        ? Container()
                                        : Image.memory(
                                            base64Decode(base64Image),
                                            height: 35,
                                            width: 35,
                                          )
                                    : Container()
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                    color: Colors.blue,
                                    child: const Text("Pick Image from Camera",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () async {
                                      setState(() {
                                        option = true;
                                      });
                                      try {
                                        final image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        if (image == null) return;
                                        final imageTemp = File(
                                          image.path,
                                        );
                                        setState(() {
                                          this.image = imageTemp;
                                          imageBytes =
                                              imageTemp.readAsBytesSync();
                                        });
                                      } on PlatformException catch (e) {
                                        print('Failed to pick image: $e');
                                      }
                                    }),
                                option == true
                                    ? base64Image == ''
                                        ? Container()
                                        : Image.memory(
                                            base64Decode(base64Image),
                                            height: 35,
                                            width: 35,
                                          )
                                    : Container()
                              ],
                            ),
                            SizedBox(
                              height: 10,
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
                                  await AddproductApi();
                                },
                                child: Text(
                                  'Add Product',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  AddproductApi() async {
    var headers = {'Authorization': 'Bearer ${widget.token}'};

    var request = http.MultipartRequest('POST',
        Uri.parse('https://usermanage-3ydh.onrender.com/products/addproduct'));

    request.fields.addAll({
      'productname': '${_productname.text}',
      'quantity': int.parse(_quantity.text).toString(),
      'description': "${_description.text}",
      'rating': double.parse(_rating.text).toString()
    });
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage2(value)));
        var data = jsonDecode(value.toString());
        print(data);
      });
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: "Only admin can add products",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
