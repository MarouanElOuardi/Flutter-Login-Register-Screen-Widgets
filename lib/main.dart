import 'package:fireshipapp/screens/login.dart';
import 'package:fireshipapp/themes/theme.dart';
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
