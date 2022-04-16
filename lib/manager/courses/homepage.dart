import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/repositories/source.dart';

import '../../errors/error_handler.dart';
import 'models/homepage_state.dart';

final homepageNotifierProvider =
    StateNotifierProvider<HomepageNotifier, HomepageState>(
        (ref) => HomepageNotifier(ref));

class HomepageNotifier extends StateNotifier<HomepageState> {
  final StateNotifierProviderRef ref;
  HomepageNotifier(this.ref) : super(HomepageState.initial());

  Future<void> init() async {
    state = const HomepageState.loading('Getting data ...');
    final courseRepository = ref.read(coursesRepositoryProvider);
    try {
      final overview = await courseRepository.getUserCourseOverview();
      state = HomepageState.content(overview);
    } catch (error) {
      state = HomepageState.failed(getErrorMessage(error));
    }
  }

  Future<void> refresh() async => await init();

  void update() async => await init();
}
