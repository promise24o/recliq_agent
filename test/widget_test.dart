import 'package:flutter_test/flutter_test.dart';

import 'package:recliq_agent/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RAgentApp());
    await tester.pump();
    expect(find.text('Recliq-Agent'), findsAny);
  });
}
