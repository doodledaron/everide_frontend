import 'package:everide_frontend/src/constants/colors.dart';
import 'package:flutter/material.dart';

Future<dynamic> showFoundDriverDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: ((context) {
      return Dialog(
        elevation: 5.0,
        backgroundColor: Colors.white,
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: primaryColor),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 75,
                color: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Found your driver',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      );
    }),
  );
}
