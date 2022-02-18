import '../source.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: Constants.kFontFam,
        primaryColor: AppColors.primary,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: AppColors.primary,
          selectionHandleColor: AppColors.primary,
        ),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: AppColors.error,
            contentTextStyle: TextStyle(
                color: AppColors.onError, fontFamily: Constants.kFontFam)),
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.secondary),
            titleTextStyle: TextStyle(
                color: AppColors.secondary,
                fontSize: 24,
                fontFamily: Constants.kFontFam,
                fontWeight: FontWeight.bold)),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: AppColors.background, circularTrackColor: AppColors.primary),
        dialogTheme: const DialogTheme(
          backgroundColor: AppColors.onSecondary,
          elevation: 5,
        ),
        iconTheme: const IconThemeData(color: AppColors.onBackground, size: 30),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: 2,
        ),
        tabBarTheme: TabBarTheme(
            labelColor: AppColors.primary,
            labelStyle: const TextStyle(
                fontSize: 18,
                fontFamily: Constants.kFontFam,
                fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(
                fontSize: 18,
                fontFamily: Constants.kFontFam,
                fontWeight: FontWeight.w500),
            labelPadding: const EdgeInsets.all(10),
            unselectedLabelColor: AppColors.onBackground.withOpacity(.5)),
        listTileTheme: const ListTileThemeData(
            dense: true, contentPadding: EdgeInsets.zero));
  }
}
