// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'product_info.dart';

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
        actions: <Widget>[
          IconButton(icon: Icon(Icons.brightness_4), onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          })
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductInfoPage()),
                );
              },
              child: Text('Go to Product Page'),
            ),
        ],
      ),
      )
  );
  }
}
