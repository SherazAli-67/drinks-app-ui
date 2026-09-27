import 'package:drinks_app/routing/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: .light
      ),
      routerConfig: router,
      builder: (ctx, child)=> child!,
    );
  }
}
