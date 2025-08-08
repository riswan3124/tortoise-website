import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tortoise_techno/firebase_options.dart';
import 'package:tortoise_techno/screens/products_screen.dart';
import 'screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tortoise Techno Solutions Pvt. Ltd.',
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/products': (context) => const ProductsScreen(),
      },
    );
  }
}
