import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_story_app/data/model/stories.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuildStoriesItem extends ConsumerWidget {
  final ListStory story;
  const BuildStoriesItem({super.key, required this.story});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      height: 250,
      child: InkWell(
        onTap: () =>
            context.goNamed('details', pathParameters: {'sid': story.id}),
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      LinearProgressIndicator(
                    value: progress.progress,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: story.photoUrl,
                  imageBuilder: (context, imageProvider) => ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 180),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  cacheManager: CacheManager(
                    Config(
                      story.id,
                      stalePeriod: const Duration(hours: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  story.name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
