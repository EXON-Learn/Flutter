import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple To do App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? _isCheck = false;
  List<Widget> litems = [const Text('Click button and make Todos.')];

  void _createTodo() {
    setState(() {
      litems.add(Container(
        height: 50,
        color: Colors.lightBlueAccent,
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text('Test'),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: _isCheck,
                onChanged: (value) => {
                  setState(() {
                    _isCheck = value!;
                  })
                },
              ))
        ]),
      ));
    });
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return litems[index];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: 700,
            width: screenWidth,
            child: ListView.builder(
                itemBuilder: (BuildContext ctxt, int index) =>
                    buildBody(ctxt, index),
                itemCount: litems.length),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTodo,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
