import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/pages/auth_page.dart';
import 'src/providers/cart_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => UserAuthProvider()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
    ],
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
