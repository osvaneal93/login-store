import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_textfield.dart';

void main() {
  group('CustomShopTextfield widget', () {
    testWidgets('Widget muestra correctamente el icono y el texto de sugerencia', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: CustomShopTextfield(
              icon: Icons.email,
              hintText: 'Correo electrónico',
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.text('Correo electrónico'), findsOneWidget);
    });

    testWidgets('Widget cambia el color de relleno según el modo oscuro', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: const Material(
            child: CustomShopTextfield(
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
      );

      final textFieldFinder = find.byType(TextField);
      final textFieldContainer = tester.widget<TextField>(textFieldFinder);
      final textFieldDecoration = textFieldContainer.decoration;

      // Verificar el color de relleno en modo oscuro
      expect(textFieldDecoration?.fillColor, equals(const Color(0xFFFFE082).withOpacity(.5)));

      // Simular el cambio al modo claro
      // await tester.pumpWidget(
      //   MaterialApp(
      //     theme: ThemeData(brightness: Brightness.light),
      //     home: Material(child: const CustomShopTextfield()),
      //   ),
      // );

      // await tester.pumpAndSettle();
      // // Verificar el color de relleno en modo claro
      // expect(textFieldDecoration?.fillColor, equals(Color(0xFFEEEEEE).withOpacity(.5)));
    });
  });
}
