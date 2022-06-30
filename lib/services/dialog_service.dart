import 'package:flutter/material.dart';
import 'package:selina_test_app/view/constants.dart';

class DialogService {
  static void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(okText),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(serviceErrorText),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
