import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_hut/core/navigation/main_navigation.dart';
import 'package:shopping_hut/core/theme/app_theme.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Hut',
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainNavigation(),
    );
  }
}

