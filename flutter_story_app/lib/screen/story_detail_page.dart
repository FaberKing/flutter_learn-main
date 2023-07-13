import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_story_app/common/localizations_call.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/model/story_detail.dart';
import '../data/provider/story_detail_provider.dart';

class StoryDetailsPage extends ConsumerStatefulWidget {
  final String? id;

  const StoryDetailsPage({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoryDetailsPageState();
}

class _StoryDetailsPageState extends ConsumerState<StoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final storyDetail = ref.watch(storyDetailProvider(widget.id!));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleAppBarStoryDetails),
      ),
      body: storyDetail.when(
        data: (data) {
          if (data is StoriesDetail) {
            final Story story = data.story;
            if (story.id.isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            } else if (story.id.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      child: Row(
                        children: [
                          const Icon(Icons.account_circle),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            story.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: story.photoUrl,
                          height: MediaQuery.of(context).size.height - 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) =>
                              LinearProgressIndicator(
                            value: progress.progress,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          cacheManager: CacheManager(
                            Config(
                              "${story.id}_detail",
                              stalePeriod: const Duration(minutes: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(story.description),
                    ),
                  ],
                ),
              );
            } else {
              return Text(data.message);
            }
          } else {
            return Center(
              child: Text(data),
            );
          }
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
