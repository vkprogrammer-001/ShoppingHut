import 'package:flutter/material.dart';
import 'package:shopping_hut/feature/home/presentation/ui/home.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home(),
    );
  }
}

