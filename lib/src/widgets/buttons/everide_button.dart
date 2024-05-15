import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EverideButton extends StatelessWidget {
  const EverideButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: secondaryColor,
      borderRadius: BorderRadius.circular(kBorderRadiusButton),
      onTap: () {
        //the user wont able to navigate back
        context.pushNamed("primarymap");
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Everride it now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Image.asset(
                'assets/leaf.png',
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
