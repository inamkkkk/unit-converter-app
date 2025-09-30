import 'package:flutter/material.dart';

class ConversionDropdown extends StatelessWidget {
  final String selectedValue;
  final Function(String?) onChanged;
  final List<String> items;
  final String labelText;

  const ConversionDropdown({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
    required this.items,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      value: selectedValue,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}