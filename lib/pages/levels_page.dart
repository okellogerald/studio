import '../manager/user/user_actions.dart';
import '../source.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage(this.levels, {Key? key}) : super(key: key);

  final List levels;

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  late final OnBoardingPagesBloc bloc;
  final currentPage = Pages.levelsPage;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc.init(currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Your Level'),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<OnBoardingPagesBloc, OnBoardingPagesState>(
        buildWhen: (_, current) => current.page == currentPage,
        builder: (_, state) {
           log('building in the $currentPage');
          return state.when(
              laoding: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: (_, s, __) => _buildContent(_, s));
        });
  }

  Widget _buildLoading(
      Pages page, OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(Pages page, OnBoardingSupplements supp) {
    return Column(
        children: widget.levels.map((e) {
      final isSelected = e == supp.user.level;

      return AppTextButton(
        backgroundColor: AppColors.surface,
        onPressed: () {
          bloc.updateAttributes(level: e);
          push(const SignUpPage());
        },
        child: Container(
          height: 85.dh,
          decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(5.dw))),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 15.dw),
          child: AppText(e,
              color: isSelected ? AppColors.onPrimary : AppColors.onBackground,
              alignment: TextAlign.center),
        ),
        margin: EdgeInsets.only(top: 20.dh, left: 15.dw, right: 15.dw),
      );
    }).toList());
  }
}
