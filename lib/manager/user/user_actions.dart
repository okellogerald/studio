import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserActivity {
  homepageView,
  lessonPageView,
  coursesView,
  profileView,
  topicLessonsView
}

final userActionProvider =
    StateProvider<UserActivity>((ref) => UserActivity.homepageView);

String getUserActionFailureMessage(WidgetRef ref) {
  final userAction = ref.read(userActionProvider);

  switch (userAction) {
    case UserActivity.lessonPageView:
      return 'We failed to get the lesson data';
    case UserActivity.coursesView:
      return 'Could not fetch the courses';
    case UserActivity.profileView:
      return 'Could not load your profile';
    case UserActivity.topicLessonsView:
      return 'Failed to get the topic lessons data';
    case UserActivity.homepageView:
      return 'We failed to get your content.';
    default:
  }
  return "";
}


///controls re-builds or re-listens for all pages controlled by onboardingbloc
enum Pages { coursesPage, logInPage, passwordResetPage, signUpPage, levelsPage, welcomePage }
