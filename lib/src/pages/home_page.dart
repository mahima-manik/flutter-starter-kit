// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary, 
        actions: <Widget>[
          IconButton(icon: Icon(Icons.brightness_4), onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
            });
          })
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}