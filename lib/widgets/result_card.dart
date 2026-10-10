import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final double exposureIndex;
  final String riskLevel;

  const ResultCard({
    super.key,
    required this.exposureIndex,
    required this.riskLevel,
  });

  Color _getRiskColor() {
    if (riskLevel == 'Bajo') return Colors.green;
    if (riskLevel == 'Moderado') return Colors.orange;
    if (riskLevel == 'Alto') return Colors.red;
    return Colors.black;
  }

  IconData _getRiskIcon() {
    if (riskLevel == 'Bajo') return Icons.check_circle_outline;
    if (riskLevel == 'Moderado') return Icons.warning_amber_outlined;
    if (riskLevel == 'Alto') return Icons.error_outline;
    return Icons.info_outline;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getRiskColor();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              _getRiskIcon(),
              size: 48,
              color: color,
            ),
            const SizedBox(height: 16),
            Text(
              'Índice de exposición',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            Text(
              exposureIndex.toStringAsFixed(2),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const Divider(height: 32),
            Text(
              'Nivel de Riesgo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            Text(
              riskLevel.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1.2,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
