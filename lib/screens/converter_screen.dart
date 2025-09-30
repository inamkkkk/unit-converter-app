import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_converter/models/conversion_model.dart';
import 'package:unit_converter/services/unit_conversion_service.dart';
import 'package:unit_converter/widgets/conversion_dropdown.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'meters';
  String _toUnit = 'kilometers';
  double _outputValue = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLastUsedUnits();
    });
  }

  Future<void> _loadLastUsedUnits() async {
    final unitConversionService = Provider.of<UnitConversionService>(context, listen: false);
    await unitConversionService.loadLastUsedUnits();
    setState(() {
      _fromUnit = unitConversionService.fromUnit ?? 'meters';
      _toUnit = unitConversionService.toUnit ?? 'kilometers';
    });
  }

  void _convertUnits() {
    final inputValue = double.tryParse(_inputController.text) ?? 0.0;
    final convertedValue = Provider.of<UnitConversionService>(context, listen: false)
        .convert(inputValue, _fromUnit, _toUnit);

    setState(() {
      _outputValue = convertedValue;
    });

    Provider.of<UnitConversionService>(context, listen: false).saveLastUsedUnits(_fromUnit, _toUnit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number, // Allow only numeric input
              decoration: const InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ConversionDropdown(
                  selectedValue: _fromUnit,
                  onChanged: (newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                    });
                  },
                  items: Provider.of<UnitConversionService>(context).availableUnits,
                  labelText: 'From',
                ),
                ConversionDropdown(
                  selectedValue: _toUnit,
                  onChanged: (newValue) {
                    setState(() {
                      _toUnit = newValue!;
                    });
                  },
                  items: Provider.of<UnitConversionService>(context).availableUnits,
                  labelText: 'To',
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertUnits,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text('Result: $_outputValue'),
          ],
        ),
      ),
    );
  }
}