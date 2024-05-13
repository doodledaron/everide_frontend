import 'package:flutter/material.dart';

import '../constants/app_contants.dart';
import '../constants/colors.dart';

class SavedCarbonSmallCard extends StatelessWidget {
  final int carbonValue;

  const SavedCarbonSmallCard({
    super.key,
    required this.carbonValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadiusCards),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: secondaryColor,
                width: 13,
              ),
            ),
          ),
          const Spacer(),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${carbonValue}kg',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600), // Font size for '700'
                ),
                const TextSpan(
                  text: ' of carbon footprint saved',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ), // Font size for 'kg of carbon footprint'
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
