import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_converter/screens/converter_screen.dart';
import 'package:unit_converter/services/unit_conversion_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => UnitConversionService(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConverterScreen(),
    );
  }
}