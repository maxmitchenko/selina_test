import 'package:flutter/material.dart';

import '../../blocs/blocs_export.dart';

class EmailSuffixIcon extends StatelessWidget {
  final EmailState emailState;
  const EmailSuffixIcon({
    required this.emailState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = const SizedBox();
    if (emailState == EmailState.loading) {
      icon = const CircularProgressIndicator();
    } else if (emailState == EmailState.test) {
      icon = const Icon(
        Icons.close,
        color: Colors.red,
      );
    } else if (emailState == EmailState.correct) {
      icon = const Icon(
        Icons.check,
        color: Colors.green,
      );
    }
    return icon;
  }
}
