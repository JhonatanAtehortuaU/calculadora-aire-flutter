class AirQualityModel {
  final double averagePM25;

  AirQualityModel({required this.averagePM25});

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    if (json['hourly'] == null || json['hourly']['pm2_5'] == null) {
      throw Exception('Formato de respuesta incorrecto');
    }
    
    List<dynamic> pm25List = json['hourly']['pm2_5'];
    
    // Filtrar valores nulos
    List<double> validValues = pm25List
        .where((value) => value != null)
        .map((value) => (value as num).toDouble())
        .toList();

    if (validValues.isEmpty) {
      return AirQualityModel(averagePM25: 0.0);
    }

    double sum = validValues.reduce((a, b) => a + b);
    double average = sum / validValues.length;

    return AirQualityModel(averagePM25: average);
  }
}
