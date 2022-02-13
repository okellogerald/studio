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
        iconTheme: const IconThemeData(color: AppColors.onPrimary, size: 30),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: 2,
        ),
        listTileTheme: const ListTileThemeData(
            dense: true, contentPadding: EdgeInsets.zero));
  }
}
