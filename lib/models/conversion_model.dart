class ConversionModel {
  final String fromUnit;
  final String toUnit;

  ConversionModel({required this.fromUnit, required this.toUnit});

  ConversionModel.fromJson(Map<String, dynamic> json)
      : fromUnit = json['fromUnit'],
        toUnit = json['toUnit'];

  Map<String, dynamic> toJson() => {
        'fromUnit': fromUnit,
        'toUnit': toUnit,
      };
}