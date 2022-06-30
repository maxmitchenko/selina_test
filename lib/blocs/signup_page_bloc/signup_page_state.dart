part of 'signup_page_bloc.dart';

@freezed
class SignupPageState with _$SignupPageState {
  const factory SignupPageState.signUp({
    required EmailState emailState,
    @Default('') String email,
    @Default('') String name,
    @Default('') String emailErrorText,
    @Default(false) bool isLoading,
    @Default(false) bool isServerError,
    @Default(false) bool isWaitingForServer,
    @Default(false) bool needAnotherEmail,
  }) = SignupPageSignUpState;
  const factory SignupPageState.welcome() = SignupPageWelcomeState;
}
