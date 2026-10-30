import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitbari/core/widgets/fruitbari_logo.dart';
import 'package:fruitbari/features/home/presentation/widgets/category_chips.dart';

void main() {
  testWidgets('CategoryChips widget displays categories and allows selection', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CategoryChips(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify 'All Fruits' chip exists
    expect(find.text('All Fruits'), findsOneWidget);
    expect(find.text('Mangoes'), findsOneWidget);

    // Tap on 'Mangoes'
    await tester.tap(find.text('Mangoes'));
    await tester.pumpAndSettle();
  });

  testWidgets('FruitBariLogo renders variants properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              FruitBariLogo.compact(height: 36),
              FruitBariLogo.full(width: 180),
              FruitBariLogo.symbol(width: 48, height: 48),
              FruitBariLogo.monochrome(width: 120),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify widgets are in widget tree
    expect(find.byType(FruitBariLogo), findsNWidgets(4));
  });
}
