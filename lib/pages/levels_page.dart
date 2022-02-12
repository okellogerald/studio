import '../source.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage(this.levels, {Key? key}) : super(key: key);

  final List levels;

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  late final OnBoardingPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
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
    return BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
        listener: (_, state) {},
        builder: (_, state) {
          return state.when(
              laoding: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: (s, _) => _buildContent(s));
        });
  }

  Widget _buildLoading(OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(OnBoardingSupplements supp) {
    return Column(
        children: widget.levels
            .map((e) => AppTextButton(
                text: e,
                backgroundColor: AppColors.surface,
                textColor: AppColors.onBackground2,
                onPressed: () {
                  bloc.updateAttributes(level: e);
                  SignUpPage.navigateTo(context);
                },
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20.dh, left: 15.dw, right: 15.dw),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.dw, vertical: 15.dw)))
            .toList());
  }
}
