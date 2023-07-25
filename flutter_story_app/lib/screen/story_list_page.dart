import 'package:flutter/material.dart';
import 'package:flutter_story_app/common/localizations_call.dart';
import 'package:flutter_story_app/widgets/build_stories_item.dart';
import 'package:flutter_story_app/widgets/no_more_items.widget.dart';
import 'package:flutter_story_app/widgets/on_going_bottom_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../flutter_mode_config.dart';
import '../data/provider/auth_provider.dart';
import '../data/provider/stories_provider.dart';

class StoryListPage extends ConsumerStatefulWidget {
  const StoryListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryListPageState();
}

class _StoryListPageState extends ConsumerState<StoryListPage> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (currentScroll >= maxScroll) {
        ref.read(storiesProvider.notifier).getNextStoriesList();
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/story/add_story'),
        child: const Icon(Icons.add_a_photo_rounded),
      ),
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => ref.read(authStateProvider.notifier).userLogout(),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 237, 237, 237),
        title: Text(
            "${AppLocalizations.of(context)!.titleAppBarHome} : ${FlutterModeConfig.flutterMode}"),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          Consumer(
            builder: (context, ref, child) {
              final stories = ref.watch(storiesProvider);
              return stories.when(
                loading: () => const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (data) {
                  return SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final story = data[index];
                      return BuildStoriesItem(
                        story: story,
                        key: widget.key,
                      );
                    },
                  );
                },
                error: (e, stack) => SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.info),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.warningErrorMessages} : $e",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onGoingLoading: (data) {
                  return SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final story = data[index];
                      return BuildStoriesItem(
                        story: story,
                        key: widget.key,
                      );
                    },
                  );
                },
                onGoingError: (data, e, stack) {
                  return SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final story = data[index];
                      return BuildStoriesItem(
                        story: story,
                        key: widget.key,
                      );
                    },
                  );
                },
              );
            },
          ),
          const NoMoreItems(),
          const OnGoingBottomWidget(),
        ],
      ),
    );
  }
}
