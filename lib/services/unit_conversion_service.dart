import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitConversionService extends ChangeNotifier {
  String? fromUnit;
  String? toUnit;
  final List<String> _availableUnits = ['meters', 'kilometers', 'miles', 'grams', 'kilograms', 'pounds', 'celsius', 'fahrenheit'];

  List<String> get availableUnits => _availableUnits;

  double convert(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) {
      return value;
    }

    // Length conversions
    if (fromUnit == 'meters' && toUnit == 'kilometers') {
      return value / 1000;
    } else if (fromUnit == 'kilometers' && toUnit == 'meters') {
      return value * 1000;
    } else if (fromUnit == 'miles' && toUnit == 'kilometers') {
      return value * 1.60934;
    } else if (fromUnit == 'kilometers' && toUnit == 'miles') {
      return value / 1.60934;
    } else if (fromUnit == 'meters' && toUnit == 'miles'){
      return value / 1609.34;
    } else if (fromUnit == 'miles' && toUnit == 'meters'){
      return value * 1609.34;
    }

    // Weight Conversions
    if (fromUnit == 'grams' && toUnit == 'kilograms'){
      return value / 1000;
    } else if (fromUnit == 'kilograms' && toUnit == 'grams'){
      return value * 1000;
    } else if (fromUnit == 'pounds' && toUnit == 'kilograms') {
      return value * 0.453592;
    } else if (fromUnit == 'kilograms' && toUnit == 'pounds'){
      return value / 0.453592;
    } else if (fromUnit == 'grams' && toUnit == 'pounds'){
      return value * 0.00220462;
    } else if (fromUnit == 'pounds' && toUnit == 'grams'){
      return value / 0.00220462;
    }

    // Temperature Conversions
    if (fromUnit == 'celsius' && toUnit == 'fahrenheit'){
      return (value * 9/5) + 32;
    } else if (fromUnit == 'fahrenheit' && toUnit == 'celsius'){
      return (value - 32) * 5/9;
    }

    return 0.0; // Default return, add more conversions as needed
  }

  Future<void> saveLastUsedUnits(String from, String to) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fromUnit', from);
    await prefs.setString('toUnit', to);
  }

  Future<void> loadLastUsedUnits() async {
    final prefs = await SharedPreferences.getInstance();
    fromUnit = prefs.getString('fromUnit');
    toUnit = prefs.getString('toUnit');
    notifyListeners();
  }
}