class Environment {
  final String? id;
  double temperature;
  bool light;
  final DateTime? createdDate;
  final DateTime? modifiedDate;

  Environment({
    this.id,
    required this.temperature,
    required this.light,
    this.createdDate,
    this.modifiedDate,
  });

  factory Environment.fromJson(Map<String, dynamic> json) {
    var tempValue = json['Temperature'];
    double temperature = (tempValue is int) ? tempValue.toDouble() : tempValue;
    try {
      return Environment(
        temperature: temperature,
        light: json['Light'] as bool,
        id: json['Id'] as String,
        createdDate: DateTime.parse(json['CreatedDate'] as String),
        modifiedDate: DateTime.parse(json['ModifiedDate'] as String),
      );
    } catch (e) {
      throw FormatException('Invalid JSON structure: $e');
    }
  }

  Map<String, dynamic> toJson() {
    var json = {
      'Temperature': temperature,
      'Light': light,
    };

    if(id != null) {
      json['Id'] = id!;
    }
    return json;
  }
}
