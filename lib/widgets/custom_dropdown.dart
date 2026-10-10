import 'package:flutter/material.dart';
import '../models/city_model.dart';

class CustomDropdown extends StatelessWidget {
  final List<City> cities;
  final City? selectedValue;
  final ValueChanged<City?> onChanged;

  const CustomDropdown({
    super.key,
    required this.cities,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<City>(
      decoration: InputDecoration(
        labelText: 'Ciudad',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        prefixIcon: const Icon(Icons.location_city),
      ),
      value: selectedValue,
      items: cities.map((City city) {
        return DropdownMenuItem<City>(
          value: city,
          child: Text(city.name),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Por favor seleccione una ciudad' : null,
    );
  }
}
