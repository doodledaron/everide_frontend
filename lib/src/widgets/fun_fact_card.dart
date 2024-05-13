import 'package:flutter/material.dart';

import '../constants/app_contants.dart';
import '../constants/colors.dart';

class FunFactCard extends StatelessWidget {
  final int carbonValue;

  const FunFactCard({
    super.key,
    required this.carbonValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadiusCards),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: secondaryColor,
                width: 13,
              ),
            ),
            child: const Center(
              child: Text(
                'CO2',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fun fact',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  maxLines: 6,
                  'Did you know? Carpooling with just one person can reduce your carbon footprint by up to 2,000 pounds per year!',
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
