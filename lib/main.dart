import 'package:fireshipapp/screens/login.dart';
import 'package:fireshipapp/themes/theme.dart';
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
    await Firebase.initializeApp(
      // name: 'PublicEye',
      options: const FirebaseOptions(
          apiKey: "AIzaSyBiioqYt2RI-vR0BUbfejQUBd8nUv0SOos",
          authDomain: "flutterpubliceye.firebaseapp.com",
          projectId: "flutterpubliceye",
          storageBucket: "flutterpubliceye.appspot.com",
          messagingSenderId: "372069346669",
          appId: "1:372069346669:web:2c72f0b5dc80468998be64"),
    );
  

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the ThemeProvider to get the current theme mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp(
      theme: isDarkMode ? darkTheme : lightTheme,
      themeMode: ThemeMode.system, // or ThemeMode.light or ThemeMode.dark
      title: 'PublicEye',
      home: const Login(),
    );
  }
}
