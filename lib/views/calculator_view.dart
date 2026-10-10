import 'package:flutter/material.dart';
import '../controllers/air_quality_controller.dart';
import '../models/city_model.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/result_card.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _formKey = GlobalKey<FormState>();
  final AirQualityController _controller = AirQualityController();

  final List<City> _cities = [
    City(name: 'Cartagena', latitude: 10.3997, longitude: -75.5144),
    City(name: 'Medellín', latitude: 6.2518, longitude: -75.5636),
    City(name: 'Bogotá', latitude: 4.6097, longitude: -74.0817),
    City(name: 'Cali', latitude: 3.4516, longitude: -76.5320),
    City(name: 'Barranquilla', latitude: 10.9685, longitude: -74.7813),
  ];

  City? _selectedCity;
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();

  bool _isLoading = false;
  double? _exposureIndex;
  String? _riskLevel;

  @override
  void dispose() {
    _dateController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 5)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _calculateRisk() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _exposureIndex = null;
        _riskLevel = null;
      });

      double hours = double.parse(_hoursController.text);
      
      final result = await _controller.calculateExposureIndex(
        _selectedCity!,
        _dateController.text,
        hours,
      );

      setState(() {
        _isLoading = false;
        if (result['success']) {
          _exposureIndex = result['index'];
          _riskLevel = result['riskLevel'];
        } else {
          _showErrorSnackBar(result['message']);
        }
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calidad del Aire', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Calculadora de Riesgo de Exposición',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Seleccione la ciudad, fecha y el tiempo de exposición para estimar su riesgo.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                CustomDropdown(
                  cities: _cities,
                  selectedValue: _selectedCity,
                  onChanged: (City? newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                
                CustomTextField(
                  controller: _dateController,
                  label: 'Fecha de consulta',
                  hint: 'YYYY-MM-DD',
                  icon: Icons.calendar_today_rounded,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) => value == null || value.isEmpty ? 'Por favor seleccione una fecha' : null,
                ),
                const SizedBox(height: 20),
                
                CustomTextField(
                  controller: _hoursController,
                  label: 'Horas de exposición',
                  hint: 'Ej. 5',
                  icon: Icons.timer_outlined,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese las horas';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Ingrese un número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _calculateRisk,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading 
                        ? const SizedBox(
                            width: 24, 
                            height: 24, 
                            child: CircularProgressIndicator(strokeWidth: 2)
                          )
                        : const Text(
                            'Calcular Índice',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                if (_exposureIndex != null && _riskLevel != null)
                  ResultCard(
                    exposureIndex: _exposureIndex!,
                    riskLevel: _riskLevel!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
