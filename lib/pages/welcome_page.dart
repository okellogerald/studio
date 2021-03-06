import 'package:silla_studio/pages/courses_page.dart';

import '../manager/onboarding/providers/user_details.dart';
import '../manager/user_action.dart';
import '../widgets/app_text_field.dart';
import '../widgets/date_selector.dart';
import '../widgets/gender_selector.dart';
import '../widgets/page_app_bar.dart';
import 'source.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDetailsProvider);
    return Scaffold(
        appBar: const PageAppBar(
            title: 'Welcome to Siila !',
            subtitle: 'We would like to know about you.'),
        body: Padding(
          padding: EdgeInsets.only(top: 40.dh),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AppTextField(
                  text: ref.watch(userDetailsProvider).name,
                  type: ValueType.name,
                  onChanged: (name) => updateUserDetails(ref, name: name),
                  hintText: '',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  label: 'Your Name',
                ),
                DateSelector(
                  title: 'Your Date of Birth',
                  date: user.dateOfBirth,
                  onDateSelected: (dateOfBirth) =>
                      updateUserDetails(ref, dateOfBirth: dateOfBirth),
                ),
                SizedBox(height: 20.dh),
                GenderSelector(
                    title: 'Your Gender',
                    onGenderSelected: (gender) =>
                        updateUserDetails(ref, gender: gender),
                    selectedGender: user.gender,
                    error: ''),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildNextButton());
  }

  _buildNextButton() {
    return BottomAppBar(
      child: AppTextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            handleUserAction(ref, UserAction.saveWelcomePageData);
            push(const CoursesPage());
          }
        },
        text: 'NEXT',
        height: 50.dh,
        margin: EdgeInsets.only(bottom: 30.dh, right: 15.dw, left: 15.dw),
        backgroundColor: AppColors.primary,
        textColor: AppColors.onPrimary,
        borderRadius: 30.dw,
      ),
    );
  }
}
