import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer_project/provider/video_notifier.dart';
import 'package:videoplayer_project/utils/utils.dart';

import '../widget/buffer_slider_controller_widget.dart';
import '../widget/video_controller_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController? controller;
  bool isVideoInitialize = false;

  void videoInitialize() async {
    final previousVideoController = controller;
    // final videoController = VideoPlayerController.asset("assets/butterfly.mp4");
    final videoController = VideoPlayerController.network(
      "https://github.com/dicodingacademy/assets/releases/download/release-video/VideoDicoding.mp4",
    );

    // final VideoPlayerController controllerFromAsset =
    //     VideoPlayerController.asset("assets/nama_berkas.ext");

    // final VideoPlayerController controllerFromNetwork =
    //     VideoPlayerController.network("tautan_berkas");

    // final VideoPlayerController controllerFromFile =
    //     VideoPlayerController.file("path_direktori_berkas");

    // final VideoPlayerController controllerFromUri =
    //     VideoPlayerController.contentUri(uriValue);

    await previousVideoController?.dispose();

    try {
      await videoController.initialize();
    } catch (e) {
      log("Error initializing video: $e");
    }
    if (mounted) {
      setState(() {
        controller = videoController;
        isVideoInitialize = controller!.value.isInitialized;
      });

      if (isVideoInitialize) {
        final provider = context.read<VideoNotifier>();
        controller?.addListener(() {
          provider.duration = controller?.value.duration ?? Duration.zero;
          provider.position = controller?.value.position ?? Duration.zero;
          provider.isPlay = controller?.value.isPlaying ?? false;
        });
      }
    }
  }

  @override
  void initState() {
    videoInitialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player Project"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          isVideoInitialize
              ? AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: VideoPlayer(
                    controller!,
                  ),
                )
              : const CircularProgressIndicator(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<VideoNotifier>(
                  builder: (context, value, child) {
                    final duration = value.duration;
                    final position = value.position;
                    return BufferSliderControllerWidget(
                      maxValue: duration.inSeconds.toDouble(),
                      currentValue: position.inSeconds.toDouble(),
                      minText: durationToTimeString(position),
                      maxText: durationToTimeString(duration),
                      onChanged: (value) async {
                        final newPosition = Duration(seconds: value.toInt());
                        await controller?.seekTo(newPosition);
                        await controller?.play();
                      },
                    );
                  },
                ),
                Consumer<VideoNotifier>(builder: (context, value, child) {
                  final isPlay = value.isPlay;
                  return VideoControllerWidget(
                    onPlayTapped: () {
                      controller?.play();
                    },
                    onPauseTapped: () {
                      controller?.pause();
                    },
                    isPlay: isPlay,
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
