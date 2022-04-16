import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/validation_logic.dart';
import 'onboarding/user_details_providers.dart';
import 'onboarding/user_notifier.dart';
import 'user_onboarding/pages_provider.dart';

enum UserAction {
  logIn,
  signUp,
  saveWelcomePageData,
  sendPasswordResetLink,
  viewHomepage,
  viewProfile,
  viewTopic,
  viewCourses,
  viewLesson,
  logOut
}

extension UserActionExtension on UserAction {
  bool get isSendingPasswordResetLink =>
      this == UserAction.sendPasswordResetLink;
  bool get isLoggingIn => this == UserAction.logIn;
  bool get isSigningUp => this == UserAction.signUp;
  bool get isSavingWelcomePageData => this == UserAction.saveWelcomePageData;

  bool get haveErrorShownBySnackBar =>
      this == UserAction.viewHomepage ||
      this == UserAction.viewProfile ||
      this == UserAction.viewTopic ||
      this == UserAction.viewLesson;
}

final userActionProvider =
    StateProvider<UserAction>((ref) => UserAction.viewHomepage);

///checks if there is a need to validate something before performing the action.
///e.g when logging in, we need to check if the email is valid before sending
///the request.
void handleUserAction(WidgetRef ref, UserAction userAction) async {
  final userNotifier = ref.read(userNotifierProvider.notifier);

  final errors = <String, String?>{};
  final user = ref.read(userDetailsProvider);
  final password = ref.read(passwordProvider);
  final password2 = ref.read(confirmationPasswordProvider);

  switch (userAction) {
    case UserAction.sendPasswordResetLink:
      errors['email'] = validateEmail(user.email);
      break;
    case UserAction.signUp:
      errors['password'] = validatePassword(password);
      errors['username'] = validateText(user.name, 'Username');
      errors['confirmingPassword'] = validatePasswords(password, password2);
      break;
    case UserAction.logIn:
      errors['email'] = validateEmail(user.email);
      errors['password'] = validatePassword(password);
      break;
    case UserAction.saveWelcomePageData:
      errors['name'] = validateText(user.name, 'Name');
      errors['gender'] = validateText(user.gender, 'Gender');
      break;
    case UserAction.viewHomepage:
    case UserAction.viewProfile:
    case UserAction.viewTopic:
    case UserAction.viewLesson:
    case UserAction.logOut:
    case UserAction.viewCourses:
      break;
  }

  ref.read(userValidationErrorsProvider.state).state = errors;

  final hasErrors = checkErrors(errors);
  if (!hasErrors) {
    if (userAction.isLoggingIn) await userNotifier.logIn();
    if (userAction.isSigningUp) await userNotifier.signUp();
    if (userAction.isSendingPasswordResetLink) {
      await userNotifier.sendPasswordResetEmail();
    }
  }
  return;
}

///updating the page so that ref listening works properly i.e does not call
///other pages for an action done on another page.
Future<bool> handleStateOnPop(WidgetRef ref, Pages toPage) async {
  ref.read(pagesProvider.state).state = toPage;
  return true;
}

///updates the current page to pages provider
void handleStateOnInit(WidgetRef ref, Pages currentPage) {
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    ref.read(pagesProvider.state).state = currentPage;
  });
}
