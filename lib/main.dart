import 'dart:ffi';
import 'dart:convert';

import 'package:intl/intl.dart';
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
  var _url = Uri.parse('');
  final _itemsLength = <int>[];

  Map<String, dynamic> json = {};

  @override
  void initState(){
    super.initState();
    callApi();
  }

  void callApi() async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    _url = Uri.parse('https://xn--299a1v27nvthhjj.com/api/' + formatter.format(now));
    final response = await http.get(_url);
    json = jsonDecode(response.body);
    int i = 0;
    setState(() {
      List<String> meals = ['breakfast', 'lunch', 'dinner'];
      meals.forEach((meal) {
        _itemsLength.add(0);
        _items.add(meal);
        json['meal'][meal].split('/').forEach((menu) {
          _items.add(menu);
          _itemsLength[i]++;
        });
        i++;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    int length = 0;
    int meal = 0;
    return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(outPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: windowHeight-outPadding*4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _items.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (['breakfast', 'lunch', 'dinner'].contains(_items[index])) {
                            Map<String, String> mealName = {
                              'breakfast': '아침',
                              'lunch': '점심',
                              'dinner': '저녁',
                            };
                            length = 0;
                            meal++;
                            return Container(
                              height: 20,
                              margin: const EdgeInsets.all(8.0),
                              child: Text(mealName[_items[index]]!, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            length++;
                            BorderRadius borderRadiusOption = const BorderRadius.only();
                            if (length == 1) {
                              borderRadiusOption = const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0)
                              );
                            } else if (length == _itemsLength[meal-1]) {
                              borderRadiusOption = const BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)
                              );
                            }
                            return Container(
                              height: 50,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_items[index]),
                              decoration: BoxDecoration(
                                borderRadius: borderRadiusOption,
                                color: const Color.fromRGBO(249, 249, 250, 1),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
            )
          )
        );
  }
}