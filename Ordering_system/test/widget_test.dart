import 'package:flutter_test/flutter_test.dart';
import 'package:ordering_system/main.dart';

void main() {
  testWidgets('Clothing app loads welcome screen initially', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ClothingApp());
    await tester.pumpAndSettle();

    // Verify Welcome Screen title and buttons are present
    expect(find.text('TRENDY CLOTHES'), findsOneWidget);
    expect(find.text('SIGN IN TO YOUR ACCOUNT'), findsOneWidget);
    expect(find.text('CONTINUE AS GUEST'), findsOneWidget);
  });
}
