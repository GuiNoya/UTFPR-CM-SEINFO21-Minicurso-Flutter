import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/app_colors.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({
    Key? key,
    this.label,
    required this.value,
    required this.maxValue,
    this.color,
    this.size = 8,
  }) : super(key: key);

  final String? label;
  final int value;
  final int maxValue;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (label != null) ...[
          Text(label!, style: TextStyle(fontSize: size)),
          const SizedBox(width: 8),
        ],
        Text(
          value.toString().padLeft(3),
          style: TextStyle(fontSize: size),
        ),
        Expanded(
          child: LinearPercentIndicator(
            backgroundColor: AppColors.darkPurple,
            progressColor: color ?? AppColors.neonGreen,
            percent: min(value / maxValue, 1),
            lineHeight: size,
          ),
        ),
      ],
    );
  }
}
