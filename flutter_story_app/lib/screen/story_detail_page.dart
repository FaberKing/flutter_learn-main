import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_story_app/common/localizations_call.dart';
import 'package:flutter_story_app/data/model/flavor_config.dart';
import 'package:go_router/go_router.dart';
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
          if (data is StoryDetail) {
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
                    const SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        story.description,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 5,
                      color: Colors.black,
                    ),
                    if (((story.lat != '0' && story.lat != 0) &&
                            (story.lon != '0' && story.lon != 0)) &&
                        FlavorConfig.instance.values.check)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .textCoodinatesDetails),
                                TextButton(
                                  onPressed: () {
                                    final Map loc = {
                                      'lat': story.lat!,
                                      'lon': story.lon!
                                    };
                                    context.goNamed('details_map',
                                        pathParameters: {'sid': story.id},
                                        extra: loc);
                                  },
                                  child: Text(AppLocalizations.of(context)!
                                      .labelTextButtonLocateMap),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Latitude: ${story.lat}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Longitude: ${story.lon}"),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
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
          child: Text(
              "${AppLocalizations.of(context)!.warningErrorMessages} : ${error.toString()}"),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
