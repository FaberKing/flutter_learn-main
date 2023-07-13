import 'dart:io';

import 'package:flutter_story_app/data/provider/shared_preference_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/api_services.dart';
import '../db/auth_repository.dart';

final storyDetailProvider =
    FutureProvider.autoDispose.family<dynamic, String>((ref, id) async {
  const apiServices = ApiServices();
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  late AuthRepository authRepository;

  try {
    authRepository = AuthRepository(sharedPreferences: sharedPreferences);
    final userData = authRepository.userStorage();

    final story = await apiServices.getStoryDetails(userData.token, id);

    if (story.story.id.isEmpty) {
      return 'No Data Available';
    } else {
      return story;
    }
  } on SocketException catch (_) {
    return 'No Internet Connection';
  } catch (e) {
    return 'error ===>> $e';
  }
});
