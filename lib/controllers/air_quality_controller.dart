import '../models/city_model.dart';
import '../services/api_service.dart';

class AirQualityController {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> calculateExposureIndex(City city, String date, double hours) async {
    try {
      final airQualityData = await _apiService.fetchAirQuality(city, date);
      
      double exposureIndex = airQualityData.averagePM25 * hours;
      String riskLevel = _determineRiskLevel(exposureIndex);

      return {
        'success': true,
        'index': exposureIndex,
        'riskLevel': riskLevel,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  String _determineRiskLevel(double index) {
    if (index < 100) {
      return 'Bajo';
    } else if (index >= 100 && index <= 200) {
      return 'Moderado';
    } else {
      return 'Alto';
    }
  }
}
