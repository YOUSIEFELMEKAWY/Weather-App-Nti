import 'package:flutter/cupertino.dart';

class TempWidget extends StatelessWidget {
  final String label;
  final double temp;
  final Color color;
  const TempWidget({super.key, required this.label, required this.temp, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${temp.round()}°',
          style: TextStyle(
            fontSize: 20,
            color: color,
          ),
        ),
      ],
    );
  }
}
