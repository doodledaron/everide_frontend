import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class GreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const GreenButton({
    super.key,
    required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        splashColor: primaryColor,
        borderRadius: BorderRadius.circular(25),
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
