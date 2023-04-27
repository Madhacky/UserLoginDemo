import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Homepage2 extends StatefulWidget {
  var data;
  Homepage2(this.data, {super.key});

  @override
  State<Homepage2> createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {
  late Future<dynamic> futuredata = getproductAPi();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd2dfff),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ALL PRODUCTS",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              // Image.network(
              //   '${data['new_product']['image']}',
              //   height: 150,
              //   width: 150,
              // ),
              FutureBuilder<dynamic>(
                future: futuredata,
                builder: (
                  BuildContext context,
                  snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: SpinKitWave(
                      color: Colors.blue,
                      size: 18,
                    ));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      print(productdata.length);
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: productdata.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.5),
                              child: Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTile(
                                    title: Text(
                                        '${productdata[index]['productname']}'),
                                    subtitle:
                                        productdata[index]['instock'] == true
                                            ? Text(
                                                'INSTOCK',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              )
                                            : Text(
                                                'OUT OF STOCK',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                    leading: Image.network(
                                        '${productdata[index]['image']}'),
                                    children: [
                                      Text(
                                          '${productdata[index]['description']}')
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ]),
      ),
    );
  }

  var productdata;
  getproductAPi() async {
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse('https://usermanage-3ydh.onrender.com/products/allproducts'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      productdata = json.decode(response.body);

      print(productdata);
    } else {
      print(response.reasonPhrase);
    }

    return response;
  }
}
