import 'package:flutter/material.dart';

import '../custom_loading_indicator.dart';

Future<dynamic> showFindingDriverDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: ((context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        backgroundColor: Colors.white,
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(20.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLoadingIndicator(),
              SizedBox(
                height: 15,
              ),
              Text(
                'Finding Your EveRide!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    }),
  );
}
