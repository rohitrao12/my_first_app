import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/data/repositories/mock_shop_repository.dart';
import 'package:my_first_app/main.dart';

void main() {
  testWidgets('11FIT App smoke test - verifies brand logo and navigation tabs',
      (WidgetTester tester) async {
    final repository = MockShopRepository();

    await tester.pumpWidget(MyApp(repository: repository));
    await tester.pumpAndSettle();

    // Verify brand logo is present
    expect(find.text('11FIT'), findsWidgets);

    // Verify bottom navigation labels
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Wishlist'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Verify hero banner text
    expect(find.text('BUILT TO\nMOVE.'), findsOneWidget);
  });
}
