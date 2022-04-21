import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

import '../../controllers/splitter_controller.dart';
import 'loading_audio.dart';
import 'music_splitter.dart';
import 'saving_audio_page.dart';

class SplitterPage extends StatelessWidget {
  const SplitterPage({
    Key? key,
    required this.filePath,
    required this.songName,
  }) : super(key: key);

  final String filePath, songName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splitter'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SavingAudioPage(
                    thePath: "test/path/",
                  ));
            },
            icon: const Icon(FeatherIcons.share2),
          )
        ],
      ),
      body: GetBuilder<SplitterController>(
        init: SplitterController(filePath: filePath, songName: songName),
        builder: (controller) {
          return controller.state == SplitterState.loadingAudio
              ? const LoadingAudioPage()
              : MusicSplitterPage(controller: controller);
        },
      ),
    );
  }
}
