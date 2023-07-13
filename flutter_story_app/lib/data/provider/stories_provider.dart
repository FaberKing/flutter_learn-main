import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_story_app/data/provider/stories_notifier.dart';

final asyncStoriesProvider =
    AsyncNotifierProvider.autoDispose<AsyncStoriesNotifier, dynamic>(
  () {
    return AsyncStoriesNotifier();
  },
);
