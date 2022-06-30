import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:selina_test_app/services/wait_service.dart';

import '../../view/constants.dart';

part 'signup_page_bloc.freezed.dart';
part 'signup_page_event.dart';
part 'signup_page_state.dart';

enum EmailState { correct, test, loading, initial }

class SignupPageBloc extends Bloc<SignupPageEvent, SignupPageState> {
  static const List<String> _forbidenEmailsList = ['test'];

  SignupPageBloc()
      : super(const SignupPageState.signUp(emailState: EmailState.initial)) {
    on<_SignupPageSignUpEvent>(_signUp);
    on<_SignupPageChooseAnotherEmailEvent>(_chooseAnotherEmail);
    on<_SignupPageEnterEmailEvent>(
      _checkEmail,
      transformer: restartable(),
    );
    on<_SignupPageEnterNameEvent>(_checkName);
  }

  bool _isEmailForbiden(String value) {
    for (String v in _forbidenEmailsList) {
      if (value.contains(v)) {
        return true;
      }
    }
    return false;
  }

  Future<void> _checkEmail(
    _SignupPageEnterEmailEvent event,
    Emitter<SignupPageState> emit,
  ) async {
    final currentState = state;
    if (currentState is SignupPageSignUpState) {
      emit(currentState.copyWith(emailState: EmailState.initial));
      await WaitService.wait(1);
      final temp = event.value.trim().toLowerCase();
      emit(currentState.copyWith(emailState: EmailState.loading, email: temp));
      await WaitService.wait(1);
      if (temp.isEmpty) {
        return emit(
            currentState.copyWith(emailState: EmailState.initial, email: temp));
      } else if (_isEmailForbiden(temp)) {
        return emit(currentState.copyWith(
            emailState: EmailState.test,
            emailErrorText: emailErrorText,
            email: temp));
      } else {
        return emit(currentState.copyWith(
            emailState: EmailState.correct, emailErrorText: '', email: temp));
      }
    }
  }

  Future<void> _checkName(
    _SignupPageEnterNameEvent event,
    Emitter<SignupPageState> emit,
  ) async {
    final currentState = state;
    if (currentState is SignupPageSignUpState) {
      final temp = event.value.trim();
      return emit(currentState.copyWith(name: temp));
    }
  }

  Future<void> _signUp(
      _SignupPageSignUpEvent event, Emitter<SignupPageState> emit) async {
    final currentState = state;
    if (currentState is SignupPageSignUpState) {
      emit(currentState.copyWith(isLoading: true));
      await WaitService.wait(2);
      if (currentState.email.contains('1')) {
        emit(currentState.copyWith(isLoading: false, needAnotherEmail: true));
      } else if (currentState.email.contains('2')) {
        emit(currentState.copyWith(
            isLoading: false, isWaitingForServer: true, isServerError: true));
        await WaitService.wait(5);
        emit(currentState.copyWith(
            isWaitingForServer: false, isServerError: false));
      } else {
        emit(const SignupPageState.welcome());
      }
    }
  }

  Future<void> _chooseAnotherEmail(_SignupPageChooseAnotherEmailEvent event,
      Emitter<SignupPageState> emit) async {
    final currentState = state;
    if (currentState is SignupPageSignUpState) {
      emit(
        currentState.copyWith(
          isLoading: false,
          needAnotherEmail: false,
          email: '',
          isServerError: false,
          isWaitingForServer: false,
          emailState: EmailState.initial,
        ),
      );
    }
  }
}
