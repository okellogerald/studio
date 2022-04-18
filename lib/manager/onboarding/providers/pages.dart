// ignore_for_file: constant_identifier_names
import 'package:flutter_riverpod/flutter_riverpod.dart';

///available to avoid rebuilds when the pages share the same notifier
///for onboarding pages
enum Pages {
  login_page,
  signup_page,
  welcome_page,
  password_reset_page,
  levels_page,
  profile_page
}

final pagesProvider = StateProvider<Pages>((ref) => Pages.login_page);
