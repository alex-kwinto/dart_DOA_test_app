import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Author: Oleksandr Vasyliev"),
        ),
        body: Center(
          child: Text ("Position: Student"),
        )
    );
  }
}