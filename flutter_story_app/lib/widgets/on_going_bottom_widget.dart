import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../animations/loading_animation_widget.dart';
import '../data/provider/stories_provider.dart';

class OnGoingBottomWidget extends StatelessWidget {
  const OnGoingBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
        child: Consumer(builder: (context, ref, child) {
          final state = ref.watch(storiesProvider);

          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            onGoingLoading: (items) =>
                const Center(child: LoadingAnimationWidget()),
            onGoingError: (items, e, stk) => Center(
              child: Column(
                children: [
                  const Icon(Icons.info),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Error : $e",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
