import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_story_app/data/provider/shared_preference_provider.dart';

import '../api/api_services.dart';
import '../db/auth_repository.dart';
import '../model/api_response.dart';

class AsyncStoriesNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  final _apiServices = const ApiServices();
  late AuthRepository _authRepository;
  late ApiResponse apiResponse;

  Future<dynamic> _getRestaurantList(AuthRepository authRepository) async {
    try {
      final userData = authRepository.userStorage();

      final stories = await _apiServices.getAllStories(userData.token);

      if (stories.listStory.isEmpty) {
        return 'No Data Available';
      } else {
        ref.keepAlive();
        return stories;
      }
    } on SocketException catch (_) {
      return 'No Internet Connection';
    } catch (e) {
      return 'error ===>> $e';
    }
  }

  @override
  Future<dynamic> build() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    _authRepository = AuthRepository(sharedPreferences: sharedPreferences);
    return _getRestaurantList(_authRepository);
  }

  Future<String> addStory(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    final userData = _authRepository.userStorage();

    state = const AsyncValue.loading();

    try {
      state = await AsyncValue.guard(() async {
        apiResponse = await _apiServices.uploadStory(
          bytes,
          fileName,
          description,
          userData.token,
        );

        return _getRestaurantList(_authRepository);
      });
    } on SocketException catch (_) {
      return 'No Internet Connection';
    } catch (e) {
      return 'error ===>> $e';
    }
    return apiResponse.message;
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
