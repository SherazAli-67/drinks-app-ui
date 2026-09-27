import 'package:flutter/material.dart';

class DrinkDetailScreen extends StatelessWidget {
  const DrinkDetailScreen({super.key, required this.drinkId});

  final String drinkId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(drinkId)));
  }
}
