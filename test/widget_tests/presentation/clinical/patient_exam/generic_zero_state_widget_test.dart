import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bewell_pro_core/presentation/clinical/patient_exam/widgets/generic_zero_state.dart';

void main() {
  testWidgets('zero state renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
          home: GenericZeroStateWidget(title: 'title', subtitle: 'sub')),
    );

    expect(find.widgetWithText(SizedBox, 'sub'), findsWidgets);
    expect(find.byType(Column), findsOneWidget);
    expect(find.text('title'), findsOneWidget);
  });
}
