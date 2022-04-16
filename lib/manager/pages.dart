// ignore_for_file: constant_identifier_names
import 'package:flutter_riverpod/flutter_riverpod.dart';

///available to avoid rebuilds when the widgets pages share the same notifier
///especially for onboarding pages
enum Pages {
  login_page,
  signup_page,
  welcome_page,
  courses_page,
  password_reset_page,
  levels_page,
  profile_page
}

final pagesProvider = StateProvider<Pages>((ref) => Pages.login_page);
