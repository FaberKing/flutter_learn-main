import 'package:flutter/material.dart';
import 'package:flutter_story_app/common/localizations_call.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/provider/stories_provider.dart';

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(storiesProvider);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loaded: (items) {
            final nomoreItems = ref.read(storiesProvider.notifier).noMoreItems;
            return nomoreItems
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      AppLocalizations.of(context)!.warningNoItemsStoryList,
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink();
          }),
    );
  }
}
