import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../manager/onboarding/user_details_providers.dart';
import '../manager/pages.dart';
import '../source.dart' hide Consumer;

class LevelsPage extends StatefulWidget {
  const LevelsPage(this.levels, {Key? key}) : super(key: key);

  final List levels;

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  final currentPage = Pages.levels_page;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
          appBar: const PageAppBar(title: 'Your Level'),
          body: Column(
              children: widget.levels.map((e) {
            final user = ref.watch(userDetailsProvider);

            final isSelected = e == user.level;

            return AppTextButton(
              backgroundColor: AppColors.surface,
              onPressed: () {
                updateUserDetails(ref, level: e);
                push(const SignUpPage());
              },
              child: Container(
                height: 85.dh,
                decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(5.dw))),
                alignment: Alignment.center,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.dw, vertical: 15.dw),
                child: AppText(e,
                    color: isSelected
                        ? AppColors.onPrimary
                        : AppColors.onBackground,
                    alignment: TextAlign.center),
              ),
              margin: EdgeInsets.only(top: 20.dh, left: 15.dw, right: 15.dw),
            );
          }).toList()));
    });
  }
}
