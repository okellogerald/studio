import '../manager/user/user_actions.dart';
import '../widgets/gender_selector.dart';
import '../source.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final OnBoardingPagesBloc bloc;
  final currentPage = Pages.welcomePage;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc.init(currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
          title: 'Welcome to Siila !',
          subtitle: 'We would like to know about you.'),
      body: _buildBody(),
      bottomNavigationBar: _buildNextButton(),
    );
  }

  _buildBody() {
    return Scaffold(
      body: BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
          bloc: bloc,
          listener: (context, state) {
            final isSuccess =
                state.maybeWhen(success: (_, __) => true, orElse: () => false);

            if (isSuccess) push(const CoursesPage());

            final error = state.maybeWhen(
                failed: (_, __, error) => error, orElse: () => null);
            if (error != null && error.isShownViaSnackBar) {
              showSnackbar(error.message, context: context);
            }
          },
          listenWhen: (_, current) {
            log('current page is ${current.page}');
            return current.page == currentPage;
          },
          buildWhen: (_, current) => current.page == currentPage,
          builder: (_, state) {
            log('building in the $currentPage');
            return state.when(
                laoding: _buildLoading,
                content: _buildContent,
                success: _buildContent,
                failed: (_, s, __) => _buildContent(_, s));
          }),
    );
  }

  Widget _buildLoading(
      Pages page, OnBoardingSupplements supp, String? message) {
    return AppLoadingIndicator(message);
  }

  Widget _buildContent(Pages page, OnBoardingSupplements supp) {
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
          GenderSelector(
              title: 'Your Gender',
              onGenderSelected: (_) => bloc.updateAttributes(gender: _),
              selectedGender: supp.user.gender,
              error: supp.errors['gender']),
        ],
      ),
    );
  }

  _buildNextButton() {
    return BottomAppBar(
      child: AppTextButton(
        onPressed: bloc.saveWelcomeDetails,
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
