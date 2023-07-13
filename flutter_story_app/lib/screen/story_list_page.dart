import 'package:flutter/material.dart';
import 'package:flutter_story_app/common/localizations_call.dart';
import 'package:flutter_story_app/data/model/stories.dart';
import 'package:flutter_story_app/widgets/build_stories_item.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/provider/auth_provider.dart';
import '../data/provider/stories_provider.dart';

class StoryListPage extends ConsumerStatefulWidget {
  const StoryListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryListPageState();
}

class _StoryListPageState extends ConsumerState<StoryListPage> {
  @override
  Widget build(BuildContext context) {
    final stories = ref.watch(asyncStoriesProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.go('/story/add_story'),
          child: const Icon(Icons.add_a_photo_rounded),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 237, 237),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () =>
                  ref.read(authStateProvider.notifier).userLogout(),
              icon: const Icon(Icons.logout_rounded),
            )
          ],
          backgroundColor: const Color.fromARGB(255, 237, 237, 237),
          title: Text(AppLocalizations.of(context)!.titleAppBarHome),
        ),
        body: stories.when(
          data: (data) {
            if (data is Stories) {
              final Stories storiesObject = data;
              if (storiesObject.listStory.isNotEmpty) {
                return ListView.builder(
                  itemCount: storiesObject.listStory.length,
                  itemBuilder: (context, index) {
                    final story = storiesObject.listStory[index];
                    return BuildStoriesItem(
                      story: story,
                      key: widget.key,
                    );
                  },
                );
              } else if (storiesObject.listStory.isEmpty) {
                return const Text('No Data');
              } else {
                return Text(storiesObject.message);
              }
            } else {
              return Text(data.runtimeType.toString());
            }
          },
          error: (error, stackTrace) => Text('$error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }
}
