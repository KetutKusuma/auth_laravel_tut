import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.nama});
  final String nama;

  @override
  Widget build(BuildContext context) {
    List<String> string = ["sdasd", 'asdasda', 'sdasdad'];

    final stringting = string.insert(2, '10');
    return Scaffold(
      body: Center(
        // List.filled(length, fill)
        child: Text("Welcome $nama"),
      ),
    );
  }
}
