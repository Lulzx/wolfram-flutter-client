import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  var result;

  wolframQuery(String input) async {
    var apiId = "API_KEY_HERE";
    var url = "http://api.wolframalpha.com/v2/result?appid=$apiId&input=$input";
    var res = await http.get(url);
    var body = res.body;

    result = "$body";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wolfram Alpha"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Enter a query to evaluate on Wolfram Alpha",
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "type query here",
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => wolframQuery(_nameController.text),
              child: Text("Evaluate"),
            ),
            if (result != null) Text(result)
          ],
        ),
      ),
    );
  }
}
