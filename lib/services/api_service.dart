import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/air_quality_model.dart';
import '../models/city_model.dart';

class ApiService {
  Future<AirQualityModel> fetchAirQuality(City city, String date) async {
    final url = Uri.parse(
        'https://air-quality-api.open-meteo.com/v1/air-quality?latitude=${city.latitude}&longitude=${city.longitude}&hourly=pm2_5&start_date=$date&end_date=$date');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return AirQualityModel.fromJson(data);
      } else {
        throw Exception('Error al cargar datos de la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo la conexión con la API: $e');
    }
  }
}
