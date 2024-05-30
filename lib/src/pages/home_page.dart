// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          })
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
