import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/topic_page/providers/providers.dart';
import 'state_notifier.dart';


void handleSelectedFilter(WidgetRef ref, int tabIndex) {
  switch (tabIndex) {
    case 0:
      ref.read(currentFilterProvider.state).state = LessonsFilter.all;
      break;
    case 1:
      ref.read(currentFilterProvider.state).state = LessonsFilter.learn;
      break;
    case 2:
      ref.read(currentFilterProvider.state).state = LessonsFilter.practice;
      break;
    case 3:
      ref.read(currentFilterProvider.state).state = LessonsFilter.free;
      break;
    case 4:
      ref.read(currentFilterProvider.state).state = LessonsFilter.paid;
      break;
    default:
  }
  ref.read(topicPageNotifierProvider.notifier).filter();
}
