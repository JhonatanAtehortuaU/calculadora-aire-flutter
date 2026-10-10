import 'package:flutter/material.dart';
import 'views/calculator_view.dart';

void main() {
  runApp(const CalidadAireApp());
}

class CalidadAireApp extends StatelessWidget {
  const CalidadAireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Calidad del Aire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0277BD), // Un tono de azul profesional
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0277BD),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0277BD),
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
      ),
      home: const CalculatorView(),
    );
  }
}
