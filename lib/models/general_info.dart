class GeneralInfo {
  final int completedLessons;
  final int lessonsCount;

  GeneralInfo({
    required this.completedLessons,
    required this.lessonsCount,
  });

  factory GeneralInfo.empty() =>
      GeneralInfo(completedLessons: 0, lessonsCount: 0);

  int get remainingClasses => lessonsCount - completedLessons;

  double get getRemainingClassesRatio => completedLessons / lessonsCount;

  int get getRemainingClassesPercent =>
      (getRemainingClassesRatio * 100).toInt();
}
