import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Get Started screen renders', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    expect(find.text(StringConst.itsTimeForA), findsOneWidget);
    expect(find.text(StringConst.getStarted), findsOneWidget);
  });
}
