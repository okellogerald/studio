import '../source.dart';

class TopicPage extends StatefulWidget {
  const TopicPage(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.topicId})
      : super(key: key);

  final String title, subtitle, topicId;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage>
    with SingleTickerProviderStateMixin {
  late final TopicPageBloc bloc;
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 5, vsync: this);
    final service = Provider.of<CoursesService>(context, listen: false);
    bloc = TopicPageBloc(service);
    bloc.init(widget.topicId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PageAppBar(title: widget.title, subtitle: widget.subtitle),
        body: _buildBody());
  }

  _buildBody() {
    return ListView(
      children: [
        _buildTabBar(),
        BlocBuilder<TopicPageBloc, TopicPageState>(
            bloc: bloc,
            builder: (_, state) {
              return state.when(
                  loading: _buildLoading,
                  content: _buildContent,
                  failed: (s, _) => _buildContent(s));
            }),
      ],
    );
  }

  Widget _buildLoading(TopicPageSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(TopicPageSupplements supp) {
    return ListView(
      padding: EdgeInsets.fromLTRB(15.dw, 40.dh, 15.dw, 10.dh),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        AppText('here we are'),
      ],
    );
  }

  _buildTabBar() {
    return Container(
      color: Colors.yellow,
      height: 50.dh,
      child: TabBar(
          controller: controller,
          indicatorColor: AppColors.primary,
          padding: const EdgeInsets.only(left: 19),
          isScrollable: true,
          tabs: const [
            Text('Recently Added'),
            Text('Playlists'),
            Text('Favourites'),
            Text('Artists'),
            Text('Albums'),
          ]),
    );
  }
}
