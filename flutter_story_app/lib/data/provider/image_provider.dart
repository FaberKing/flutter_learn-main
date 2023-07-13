import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageStateProvider = StateProvider.autoDispose(
    (ref) => <String?, dynamic>{'image': null, 'path': null});
