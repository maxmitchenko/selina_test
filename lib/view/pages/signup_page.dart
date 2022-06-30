import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selina_test_app/services/dialog_service.dart';
import 'package:selina_test_app/view/constants.dart';

import '../../blocs/blocs_export.dart';
import '../widgets/widgets_export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupPageBloc = BlocProvider.of<SignupPageBloc>(context);
    final rawDeviceHeight = MediaQuery.of(context).size.height;
    final deviceHeight = rawDeviceHeight - 20;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<SignupPageBloc, SignupPageState>(
          listener: (context, signupPageState) {
            if (signupPageState is SignupPageSignUpState) {
              if (signupPageState.isServerError) {
                DialogService.showAlertDialog(context);
              }
            }
          },
          builder: (context, signupPageState) {
            String title = greatestAppTitle;
            Widget child = const MyWelcomeText();
            Widget progressIndicator = const SizedBox();
            Widget button = const SizedBox();
            bool isLoading = false;

            if (signupPageState is SignupPageSignUpState) {
              title = signUpTitle;
              child = SignupForm(
                emailController: emailController,
                nameController: nameController,
                onEmailChanged: (value) =>
                    signupPageBloc.add(SignupPageEvent.enterEmail(value)),
                onNameChanged: (value) =>
                    signupPageBloc.add(SignupPageEvent.enterName(value)),
                emailErrorText: signupPageState.emailErrorText,
                suffixIcon: AnimatedSwitcher(
                    duration: anamationDuration,
                    child: EmailSuffixIcon(
                      emailState: signupPageState.emailState,
                    )),
              );
              void Function()? onPressed;
              if (!signupPageState.isWaitingForServer) {
                if (signupPageState.needAnotherEmail) {
                  onPressed = () {
                    emailController.clear();
                    nameController.text = signupPageState.name;
                    signupPageBloc
                        .add(const SignupPageEvent.chooseAnotherEmail());
                  };
                } else {
                  if ((signupPageState.emailState == EmailState.correct) &&
                      signupPageState.name.isNotEmpty) {
                    onPressed = () =>
                        signupPageBloc.add(const SignupPageEvent.signUp());
                  }
                }
              }
              button = ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  signupPageState.needAnotherEmail
                      ? chooseAnotherButtonText
                      : continueText,
                ),
              );
              if (signupPageState.isLoading) {
                progressIndicator = const CircularProgressIndicator();
                isLoading = true;
              }
              if (signupPageState.needAnotherEmail) {
                child = const Text(
                  chooseAnotherInfoText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: isLoading ? 0.5 : 1.0,
                  duration: anamationDuration,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: deviceHeight,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          child: AnimatedSwitcher(
                            duration: anamationDuration,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: child,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedSwitcher(
                              duration: anamationDuration,
                              child: button,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: deviceHeight / 2,
                  child: progressIndicator,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
