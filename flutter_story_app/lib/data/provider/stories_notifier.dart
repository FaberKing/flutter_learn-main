import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_story_app/data/model/data_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;

import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_services.dart';
import '../db/auth_repository.dart';
import '../model/api_response.dart';

class StoriesNotifier<T> extends StateNotifier<DataState<T>> {
  final SharedPreferences sharedPreferences;
  final int sizeItems;
  StoriesNotifier({
    required this.sizeItems,
    required this.sharedPreferences,
  }) : super(const DataState.loading()) {
    _authRepository = AuthRepository(sharedPreferences: sharedPreferences);
  }

  final _apiServices = const ApiServices();
  late AuthRepository _authRepository;

  List<T> stories = [];
  int? pageItems = 1;
  bool noMoreItems = false;
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  void init() {
    if (stories.isEmpty) {
      getFirstList();
    }
  }

  void updateData(List<T> result) {
    noMoreItems = result.length < sizeItems;

    if (result.isEmpty) {
      state = DataState.loaded(stories);
      pageItems = pageItems! + 1;
    } else {
      state = DataState.loaded(stories..addAll(result));
      pageItems = pageItems! + 1;
    }
  }

  Future<void> getFirstList() async {
    try {
      state = const DataState.loading();
      final userData = _authRepository.userStorage();
      final List<T> result = (await _apiServices.getAllStories(
              pageItems!, sizeItems, userData.token))
          .cast<T>();
      updateData(result);
    } catch (e) {
      // log("Error fetching first page", error: e, stackTrace: stk);
      state = DataState.error(e);
    }
  }

  Future<void> getNextStoriesList() async {
    final userData = _authRepository.userStorage();

    if (_timer.isActive && stories.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});

    if (noMoreItems) {
      pageItems = null;
      return;
    }

    if (state == DataState<T>.onGoingLoading(stories)) {
      log("Rejected");
      return;
    }

    log("Fetching next batch of items");

    state = DataState.onGoingLoading(stories);

    try {
      await Future.delayed(const Duration(seconds: 1));
      final List<T> result = (await _apiServices.getAllStories(
              pageItems!, sizeItems, userData.token))
          .cast<T>();

      updateData(result);
    } catch (e, stk) {
      log("Error fetching next page", error: e, stackTrace: stk);
      state = DataState.onGoingError(stories, e, stk);
    }
  }

  Future<String> addStory(
    List<int> bytes,
    String fileName,
    String description,
    LatLng? location,
  ) async {
    final userData = _authRepository.userStorage();
    late ApiResponse apiResponse;

    state = const DataState.loading();

    try {
      apiResponse = await _apiServices.uploadStory(
          bytes, fileName, description, userData.token, location);
      final List<T> result =
          (await _apiServices.getAllStories(1, 1, userData.token)).cast<T>();

      state = DataState.loaded(
        stories..insert(0, result.first),
      );
    } on SocketException catch (e, stk) {
      state = DataState.error(e, stk);
    } catch (e, stk) {
      state = DataState.error(e, stk);
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
