class GeneralInfo {
  final int completedLessons;
  final int lessonsCount;

  GeneralInfo({
    required this.completedLessons,
    required this.lessonsCount,
  });

  GeneralInfo copyWith(int updatedCompletedLessons) {
    return GeneralInfo(
        completedLessons: updatedCompletedLessons, lessonsCount: lessonsCount);
  }

  factory GeneralInfo.empty() =>
      GeneralInfo(completedLessons: 0, lessonsCount: 1);

  int get remainingClasses => lessonsCount - completedLessons;

  double get getRemainingClassesRatio => completedLessons / lessonsCount;

  int get getRemainingClassesPercent =>
      (getRemainingClassesRatio * 100).toInt();
}
