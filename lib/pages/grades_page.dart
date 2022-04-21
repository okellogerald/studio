import 'package:silla_studio/manager/onboarding/models/grade.dart';
import 'package:silla_studio/pages/homepage.dart';
import 'package:silla_studio/pages/levels_page.dart';
import 'package:silla_studio/pages/source.dart';
import '../manager/onboarding/providers/user_details.dart';

class GradesPage extends ConsumerWidget {
  const GradesPage(this.gradeList, this.levelList, {Key? key})
      : super(key: key);
  final List<Grade> gradeList;
  final List levelList;

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Grades')),
      body: Column(
          children: gradeList.map((e) {
        final user = ref.watch(userDetailsProvider);
        final isSelected = e.id == user.gradeId;

        return AppTextButton(
            backgroundColor: AppColors.surface,
            onPressed: () {
              updateUserDetails(ref, gradeId: e.id);
              final courseIds = ref.read(prevCourseIdsProvider);
              if (courseIds.contains(user.courseId)) {
                pushAndRemoveUntil(const Homepage());
                return;
              }
              push(LevelsPage(levelList));
            },
            child: Container(
              height: 85.dh,
              decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(5.dw))),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 15.dw),
              child: AppText(e.title,
                  color:
                      isSelected ? AppColors.onPrimary : AppColors.onBackground,
                  alignment: TextAlign.center),
            ),
            margin: EdgeInsets.only(top: 20.dh, left: 15.dw, right: 15.dw));
      }).toList()),
    );
  }
}
