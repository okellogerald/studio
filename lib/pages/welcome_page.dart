import 'package:silla_studio/widgets/option_selector.dart';

import '../source.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const WelcomePage()));
  }

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final OnBoardingPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
          title: 'Welcome to Siila!',
          subtitle: 'We would like to know about you.'),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccess =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccess) CoursesPage.navigateTo(context);

          final error = state.maybeWhen(
              failed: (_, message) => message, orElse: () => null);
          if (error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: AppText(error)));
          }
        },
        builder: (_, state) {
          return state.when(
              laoding: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: (s, _) => _buildContent(s));
        });
  }

  Widget _buildLoading(OnBoardingSupplements supp, String? message) {
    return AppLoadingIndicator(message);
  }

  Widget _buildContent(OnBoardingSupplements supp) {
    return Padding(
      padding: EdgeInsets.only(top: 40.dh),
      child: Column(
        children: [
          AppTextField(
            error: supp.errors['name'],
            text: supp.user.name,
            onChanged: (_) => bloc.updateAttributes(name: _),
            hintText: '',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'Your Name',
          ),
          DateSelector(
            title: 'Your Date of Birth',
            date: supp.user.dateOfBirth,
            onDateSelected: (_) => bloc.updateAttributes(dateOfBirth: _),
          ),
          SizedBox(height: 20.dh),
          OptionSelector(
              title: 'Your Gender',
              onValueSelected: (_) => bloc.updateAttributes(gender: _),
              value: supp.user.gender),
          _buildNextButton()
        ],
      ),
    );
  }

  _buildNextButton() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppTextButton(
            onPressed: bloc.saveWelcomeDetails,
            text: 'NEXT',
            height: 50.dh,
            width: 200.dw,
            margin: EdgeInsets.only(bottom: 40.dh, right: 15.dw),
            backgroundColor: AppColors.primary,
             textColor: AppColors.onPrimary,
          ),
        ],
      ),
    );
  }
}
