import 'package:flutter/material.dart';

import '../constants.dart';

class MyWelcomeText extends StatelessWidget {
  const MyWelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      welcomeText,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
