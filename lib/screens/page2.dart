import 'dart:convert';
import 'package:flag/flag.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:exam3/api/currency_api.dart';
import 'package:flutter/material.dart';

class Currency_Exchange_Page2 extends StatefulWidget {
  @override
  _Currency_Exchange_Page2State createState() =>
      _Currency_Exchange_Page2State();
}

class _Currency_Exchange_Page2State extends State<Currency_Exchange_Page2> {
  var _kontroller = TextEditingController();
  String? _tanlanganValue;
  int a = 23;
  int b = 0;
  List<Widget> listlar = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: (Icon(
            Icons.arrow_back_ios,
            size: 26.0,
            color: Colors.black,
          )),
        ),
        title: Text(
          "Converter",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 250.0,
                        child: TextFormField(
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: _kontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintText: "1",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      SizedBox(
                        width: 100.0,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            menuMaxHeight: 200.0,
                            hint: Text("USD"),
                            value: _tanlanganValue,
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  "USD",
                                ),
                                value: "USD",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "EUR",
                                ),
                                value: "EUR",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "RUB",
                                ),
                                value: "RUB",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "GBP",
                                ),
                                value: "GBP",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "CHF",
                                ),
                                value: "CHF",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "JPY",
                                ),
                                value: "JPY",
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "KZT",
                                ),
                                value: "KZT",
                              ),
                            ],
                            dropdownColor: Colors.grey[300],
                            onChanged: (v) {
                              setState(
                                () {
                                  _tanlanganValue = v;
                                },
                              );
                              if (_tanlanganValue == "USD") {
                                a = 23;
                              } else if (_tanlanganValue == "EUR") {
                                a = 7;
                              } else if (_tanlanganValue == "RUB") {
                                a = 18;
                              } else if (_tanlanganValue == "GBP") {
                                a = 8;
                              } else if (_tanlanganValue == "CHF") {
                                a = 3;
                              } else if (_tanlanganValue == "JPY") {
                                a = 23;
                              } else if (_tanlanganValue == "KZT") {
                                a = 13;
                              } else {
                                a = 23;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: FutureBuilder(
              future: _getCurrencyApi(),
              builder: (context, AsyncSnapshot<List<Currency>> snap) {
                var data = snap.data;
                return snap.hasData
                    ? Column(
                        children: [
                          SizedBox(height: 50.0),
                          Container(
                            child: _kontroller.text.isNotEmpty
                                ? Text(
                                    "${double.parse(data![a].nbuCellPrice.toString()) * int.parse(_kontroller.text)}" +
                                        "\t\tsoum",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Container(),
                            height: 50.0,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(250.0, 50),
                              backgroundColor: Colors.amberAccent,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  listlar.add(
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Flag.fromString(
                                          data![a].title.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(
                                        "You buyed\t\t\t" +
                                            "${double.parse(data[a].nbuCellPrice.toString()) * int.parse(_kontroller.text)}\t\t\t" +
                                            "soum",
                                      ),
                                      onLongPress: () {
                                        setState(
                                          () {
                                            listlar.removeAt(0);
                                          },
                                        );
                                      },
                                      tileColor: Colors.teal[200],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            children: listlar.isEmpty ? [] : listlar,
                          )
                        ],
                      )
                    : CircularProgressIndicator();
              },
            ),
          ),
        ],
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
