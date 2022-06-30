import 'package:flutter/material.dart';
import 'package:selina_test_app/view/constants.dart';

class SignupForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final void Function(String)? onEmailChanged;
  final void Function(String)? onNameChanged;
  final String emailErrorText;
  final Widget? suffixIcon;
  const SignupForm({
    required this.emailController,
    required this.nameController,
    this.onEmailChanged,
    this.onNameChanged,
    this.emailErrorText = '',
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          textInputAction: TextInputAction.next,
          onSubmitted: (v) {
            FocusScope.of(context).requestFocus(_focus);
          },
          controller: widget.emailController,
          onChanged: widget.onEmailChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: emailHintText,
            suffix: SizedBox(
              height: suffixIconSize,
              width: suffixIconSize,
              child: widget.suffixIcon,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.emailErrorText,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          focusNode: _focus,
          textInputAction: TextInputAction.done,
          onSubmitted: (v) {
            FocusScope.of(context).unfocus();
          },
          controller: widget.nameController,
          onChanged: widget.onNameChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: nameHintText,
            suffix: SizedBox(
              height: suffixIconSize,
              width: suffixIconSize,
            ),
          ),
        ),
      ],
    );
  }
}
