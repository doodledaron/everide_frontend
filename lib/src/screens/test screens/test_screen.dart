import 'package:everide_frontend/src/widgets/popups/driver_found_popup.dart';
import 'package:everide_frontend/src/widgets/popups/finding_driver_popup.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_loading_indicator.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            showFoundDriverDialog(context);
          },
          child: Text('Test'),
        ),
      ],
    ));
  }
}
