import 'package:flutter_story_app/data/model/data_state.dart';
import 'package:flutter_story_app/data/model/stories.dart';
import 'package:flutter_story_app/data/provider/stories_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'shared_preference_provider.dart';

final storiesProvider = StateNotifierProvider.autoDispose<
    StoriesNotifier<ListStory>, DataState<ListStory>>((ref) {
  return StoriesNotifier(
      sizeItems: 10, sharedPreferences: ref.watch(sharedPreferencesProvider))
    ..init();
});
