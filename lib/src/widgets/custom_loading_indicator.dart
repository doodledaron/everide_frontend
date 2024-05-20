import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constants/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 80,
      child: LoadingIndicator(
        indicatorType: Indicator.squareSpin,
        colors: [primaryColor],
        strokeWidth: 2,
      ),
    );
  }
}