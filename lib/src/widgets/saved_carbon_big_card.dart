import 'package:flutter/material.dart';

import '../constants/app_contants.dart';
import '../constants/colors.dart';

class SavedCarbonBigCard extends StatelessWidget {
  final int carbonValue;

  const SavedCarbonBigCard({
    super.key,
    required this.carbonValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You have saved',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                        text: ' of carbon footprint',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ), // Font size for 'kg of carbon footprint'
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
