import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../common/localizations_call.dart';
import '../data/provider/image_provider.dart';
import '../data/provider/stories_provider.dart';

class AddStoryPage extends ConsumerStatefulWidget {
  const AddStoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddStoryDialogState();
}

class _AddStoryDialogState extends ConsumerState<AddStoryPage> {
  final _descriptionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final img = ref.watch(imageStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleAppBarAddStory),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: img['path'] == null
                    ? const Icon(
                        Icons.image,
                        size: 100,
                      )
                    : _showImage(),
              ),
            ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _onCameraView(),
                    child: Text(AppLocalizations.of(context)!.buttonTextCamera),
                  ),
                  ElevatedButton(
                    onPressed: () => _onGalleryView(),
                    child:
                        Text(AppLocalizations.of(context)!.buttonTextGallery),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: TextField(
                  controller: _descriptionsController,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .hintTexStorytDescription),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            Flexible(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _onUpload().then(
                    (value) => context.pop(),
                  ),
                  child: Text(AppLocalizations.of(context)!.buttonTextUpload),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionsController.dispose();
    super.dispose();
  }

  void _onGalleryView() async {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      imageQuality: 70,
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      ref.read(imageStateProvider.notifier).state = {
        'image': pickedFile,
        'path': pickedFile.path,
      };
    }
  }

  Widget _showImage() {
    final img = ref.read(imageStateProvider);

    return kIsWeb
        ? Image.network(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.height - 200,
            img['path'].toString(),
            fit: BoxFit.cover,
          )
        : Image.file(
            height: 250,
            width: 250,
            File(img['path'].toString()),
            fit: BoxFit.cover,
          );
  }

  void _onCameraView() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      imageQuality: 70,
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      ref.read(imageStateProvider.notifier).state = {
        'image': pickedFile,
        'path': pickedFile.path,
      };
    }
  }

  Future<void> _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);

    final img = ref.read(imageStateProvider);

    final imagePath = img['path'];
    final XFile? imageFile = img['image'];
    if (imagePath == null || imageFile == null) return;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes =
        await ref.read(asyncStoriesProvider.notifier).compressImage(bytes);

    final uploadProvider =
        await ref.read(asyncStoriesProvider.notifier).addStory(
              newBytes,
              fileName,
              _descriptionsController.text,
            );

    if (uploadProvider.isNotEmpty) {
      ref.read(imageStateProvider.notifier).state = {
        'image': null,
        'path': null,
      };
    }

    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(uploadProvider.toString())),
    );
  }
}
