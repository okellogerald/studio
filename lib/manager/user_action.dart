import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/homepage/providers.dart';
import 'package:silla_studio/manager/video/providers.dart';
import '../utils/validation_logic.dart';
import 'lesson_page/providers/state_notifier.dart';
import 'onboarding/providers/courses.dart';
import 'onboarding/providers/pages.dart';
import 'onboarding/providers/user_details.dart';
import 'onboarding/providers/user_notifier.dart';
import 'topic_page/providers/state_notifier.dart';

enum UserAction {
  logIn,
  signUp,
  saveWelcomePageData,
  sendPasswordResetLink,
  viewHomepage,
  viewTopic,
  viewCourses,
  viewLesson,
  markLessonCompletionStatus,
  logOut
}

extension UserActionExtension on UserAction {
  bool get isSendingPasswordResetLink =>
      this == UserAction.sendPasswordResetLink;
  bool get isLoggingIn => this == UserAction.logIn;
  bool get isSigningUp => this == UserAction.signUp;
  bool get isSavingWelcomePageData => this == UserAction.saveWelcomePageData;

  bool get needsValidation =>
      this == UserAction.logIn ||
      this == UserAction.saveWelcomePageData ||
      this == UserAction.sendPasswordResetLink ||
      this == UserAction.signUp;

  bool get haveErrorShownBySnackBar =>
      this != UserAction.viewHomepage &&
      this != UserAction.viewTopic &&
      this != UserAction.viewLesson &&
      this != UserAction.viewCourses;
}

final userActionProvider =
    StateProvider<UserAction>((ref) => UserAction.viewHomepage);

///checks if there is a need to validate something before performing the action.
///e.g when logging in, we need to check if the email is valid before sending
///the request.
///also gets the user action stored so that tryAgainCallback in the failed
///state widget works.
void handleUserAction(WidgetRef ref, UserAction userAction) async {
  ref.read(userActionProvider.state).state = userAction;
  _updateCurrentPage(ref, userAction);
  log('user action is $userAction');

  final userNotifier = ref.read(userNotifierProvider.notifier);
  final homepageNotifier = ref.read(homepageNotifierProvider.notifier);
  final topicPageNotifier = ref.read(topicPageNotifierProvider.notifier);
  final lessonPageNotifier = ref.read(lessonPageNotifierProvider.notifier);

  final errors = <String, String?>{};
  final user = ref.read(userDetailsProvider);
  final password = ref.read(passwordProvider);
  final password2 = ref.read(confirmationPasswordProvider);

  if (userAction.needsValidation) {
    if (userAction == UserAction.sendPasswordResetLink) {
      errors['email'] = validateEmail(user.email);
    }
    if (userAction == UserAction.signUp) {
      errors['password'] = validatePassword(password);
      errors['email'] = validateEmail(user.email);
      errors['confirmingPassword'] = validatePasswords(password, password2);
    }
    if (userAction == UserAction.logIn) {
      errors['email'] = validateEmail(user.email);
      errors['password'] = validatePassword(password);
    }
    if (userAction == UserAction.saveWelcomePageData) {
      errors['name'] = validateText(user.name, 'Name');
      errors['gender'] = validateText(user.gender, 'Gender');
    }

    final hasErrors = checkErrors(errors);
    if (!hasErrors) {
      ref.read(userValidationErrorsProvider.state).state = {};
      if (userAction.isLoggingIn) await userNotifier.logIn();
      if (userAction.isSigningUp) await userNotifier.signUp();
      if (userAction.isSendingPasswordResetLink) {
        await userNotifier.sendPasswordResetEmail();
      }
      if (userAction == UserAction.saveWelcomePageData) {
        ref.refresh(coursesProvider);
      }
    } else {
      ref.read(userValidationErrorsProvider.state).state = errors;
    }
  } else {
    if (userAction == UserAction.viewHomepage) await homepageNotifier.init();
    if (userAction == UserAction.viewTopic) await topicPageNotifier.init();
    if (userAction == UserAction.viewLesson) await lessonPageNotifier.init();
    if (userAction == UserAction.logOut) await userNotifier.logOut();

    if (userAction == UserAction.markLessonCompletionStatus) {
      await ref.read(videoControllerProvider).pause();
      await lessonPageNotifier.changeLessonCompletionStatus();
    }
  }
}

///using user action to update the page the user is in to avoid re-builds for
///pages sharing the same state notifier.
///
///easier to implement than having on-init and on-pop functions updating the
///current page
void _updateCurrentPage(WidgetRef ref, UserAction userAction) {
  var page = Pages.login_page;
  switch (userAction) {
    case UserAction.logIn:
      page = Pages.login_page;
      break;
    case UserAction.sendPasswordResetLink:
      page = Pages.password_reset_page;
      break;
    case UserAction.signUp:
      page = Pages.signup_page;
      break;
    case UserAction.logOut:
      page = Pages.profile_page;
      break;
    case UserAction.saveWelcomePageData:
      page = Pages.welcome_page;
      break;
    default:
  }
  ref.read(pagesProvider.state).state = page;
}
