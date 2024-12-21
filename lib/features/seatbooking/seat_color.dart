import 'package:flutter/material.dart';
import 'package:movie_app/core/config/app_colors.dart';

class SeatColorIndicators extends StatelessWidget {
  const SeatColorIndicators({super.key});

  static final _indicators = [
    _Indicator('Selected', AppColors.yellow),
    _Indicator('Not Available', AppColors.secondary),
    _Indicator('VIP', AppColors.purple),
    _Indicator('Regular', AppColors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < _indicators.length; i += 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIndicator(_indicators[i]),
                if (i + 1 < _indicators.length)
                  _buildIndicator(_indicators[i + 1]),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildIndicator(_Indicator indicator) {
    return Row(
      children: [
        SizedBox(
          height: 9,
          width: 9,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: indicator.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          indicator.status,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _Indicator {
  final String status;
  final Color color;

  _Indicator(this.status, this.color);
}
