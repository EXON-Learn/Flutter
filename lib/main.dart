import 'dart:ffi';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const outPadding = 32.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        textTheme: GoogleFonts.notoSansNKoTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: ListViewPage()
    );
  }
}

class ListViewPage extends StatefulWidget {
  @override
  ListViewPageState createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {
  final List<String> _items = <String>[];
  final _url = Uri.parse('https://xn--299a1v27nvthhjj.com/api/2023-03-31');

  Map<String, dynamic> json = {};

  @override
  void initState(){
    super.initState();
    callApi();
  }

  void callApi() async {
    final response = await http.get(_url);
    json = jsonDecode(response.body);
    setState(() {
      List<String> meals = ['breakfast', 'lunch', 'dinner'];
      meals.forEach((meal) {
        _items.add(meal);
        json['meal'][meal].split('/').forEach((menu) {
          _items.add(menu);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Theme.of(context).colorScheme.primary),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(outPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (['breakfast', 'lunch', 'dinner'].contains(_items[index])) {
                        return Container(
                          height: 50,
                          child: Text(_items[index]),
                          margin: const EdgeInsets.all(8.0),
                        );
                      } else {
                        return Container(
                          height: 50,
                          color: Colors.lightBlueAccent,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          child: Text(_items[index]),
                        );
                      }
                    },
                  ),
                ],
              )
            )
          )
        )
      ]
    );
  }
}