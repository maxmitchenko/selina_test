part of 'signup_page_bloc.dart';

@freezed
class SignupPageEvent with _$SignupPageEvent {
  const factory SignupPageEvent.signUp() = _SignupPageSignUpEvent;
  const factory SignupPageEvent.chooseAnotherEmail() =
      _SignupPageChooseAnotherEmailEvent;
  const factory SignupPageEvent.showWelcomeText() =
      _SignupPageShowWelcomeTextEvent;
  const factory SignupPageEvent.enterEmail(String value) =
      _SignupPageEnterEmailEvent;
  const factory SignupPageEvent.enterName(String value) =
      _SignupPageEnterNameEvent;
}
