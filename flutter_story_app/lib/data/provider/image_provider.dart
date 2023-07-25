import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageStateProvider = StateProvider.autoDispose(
    (ref) => <String?, dynamic>{'image': null, 'path': null});
