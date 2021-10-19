import 'dart:convert';

import 'package:exam3/screens/page2.dart';
import 'package:http/http.dart' as http;
import 'package:exam3/api/currency_api.dart';
import 'package:flutter/material.dart';

class Currency_Exchange_Page1 extends StatefulWidget {
  @override
  _Currency_Exchange_Page1State createState() =>
      _Currency_Exchange_Page1State();
}

class _Currency_Exchange_Page1State extends State<Currency_Exchange_Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.menu,
          size: 32.0,
          color: Colors.white,
        ),
        title: Text(
          "Converter",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getCurrencyApi(),
        builder: (context, AsyncSnapshot<List<Currency>> snap) {
          var data = snap.data;
          return snap.hasData
              ? Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "1 UZS equals" +
                              "\t" +
                              data![23].cbPrice.toString() +
                              "\t" +
                              "USD",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              50.0,
                            ),
                            topRight: Radius.circular(
                              50.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40.0,
                                        ),
                                        children: [
                                          TextSpan(text: "100\n\n"),
                                          TextSpan(
                                            text: data[23].cbPrice.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  SizedBox(
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        children: [
                                          TextSpan(text: "\$\n"),
                                          TextSpan(text: "US dollar\n\n\n"),
                                          TextSpan(text: "UZS\n"),
                                          TextSpan(text: "Uzbekistan soums"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.arrow_forward_ios_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Currency_Exchange_Page2(),
            ),
          );
        },
      ),
    );
  }

  Future<List<Currency>> _getCurrencyApi() async {
    Uri url = Uri.parse("https://nbu.uz/uz/exchange-rates/json/");
    var respons = await http.get(url);

    if (respons.statusCode == 200) {
      return (json.decode(respons.body) as List)
          .map((e) => Currency.fromJson(e))
          .toList();
    } else {
      throw Exception("Error: ${respons.statusCode}");
    }
  }
}
