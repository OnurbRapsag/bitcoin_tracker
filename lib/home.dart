import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _getBitcoinPrice();
  }

  var _url = "https://blockchain.info/ticker";

  var _preco;

  void _getBitcoinPrice() async {
    http.Response response;
    response = await http.get(_url);

    Map retorno = json.decode(response.body);
    var _brl = retorno["BRL"]["buy"];

    setState(() {
      _preco = _brl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/bitcoin.png",
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ $_preco",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _getBitcoinPrice();
                },
                child: Text("Atualizar"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
