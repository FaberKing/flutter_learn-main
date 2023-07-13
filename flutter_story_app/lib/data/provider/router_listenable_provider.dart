import 'package:flutter_story_app/data/provider/router_listenable_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerListenableProvider =
    AsyncNotifierProvider<RouterListenableNotifier, void>(
        RouterListenableNotifier.new);
