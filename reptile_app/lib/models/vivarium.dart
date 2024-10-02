import 'package:reptile_app/models/environment.dart';
import 'package:reptile_app/models/parameter.dart';

// Vivarium object definition
class Vivarium {
  final String? id;
  String name;
  Environment environment;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  Parameter parameter;

  // Constructor
  Vivarium({
    this.id,
    required this.name,
    required this.environment,
    this.createdDate,
    this.modifiedDate,
    required this.parameter,
  });

  // Creates vivarium object from JSON string
  factory Vivarium.fromJson(Map<String, dynamic> json) {
    try {
      return Vivarium(
        id: json['Id'] as String,
        name: json['Name'] as String,
        environment: Environment.fromJson(json['Environment'] as Map<String, dynamic>),
        parameter: Parameter.fromJson(json['Parameter'] as Map<String, dynamic>),
        createdDate: DateTime.parse(json['CreatedDate'] as String),
        modifiedDate: DateTime.parse(json['ModifiedDate'] as String),
      );
    } catch (e) {
      throw FormatException('Invalid JSON structure: $e');
    }
  }

  // Creates JSON string from vivarium object
  Map<String, dynamic> toJson() {
    var json = {
      'Name': name,
      'Environment': environment.toJson(),
      'Parameter': parameter.toJson(),
    };

    // Assigns ID value to JSON ID
    if(id != null){
      json['Id'] = id!;
    }
    return json;
  }
}
