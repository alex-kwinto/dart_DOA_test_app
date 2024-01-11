import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/ui/detailes.dart';

void main() {
  testWidgets('DetailsScreen has a title and position', (tester) async {
    await tester.pumpWidget(const MaterialApp(home:const DetailsScreen()));

    final titleFinder = find.text('Author: Oleksandr Vasyliev');
    final messageFinder = find.text('Position: Student');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
