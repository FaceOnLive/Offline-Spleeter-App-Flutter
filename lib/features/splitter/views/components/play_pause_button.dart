import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_defaults.dart';
import '../../controllers/splitter_controller.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({
    Key? key,
    required this.onPlay,
    required this.onPause,
  }) : super(key: key);

  final void Function() onPlay;
  final void Function() onPause;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  final _splitterController = Get.find<SplitterController>();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDefaults.duration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleIcon() {
    setState(() {
      if (_splitterController.state == SplitterState.playing) {
        _controller.reverse();
        _splitterController.state = SplitterState.paused;
        _splitterController.update();
        _splitterController.onPause();
      } else {
        _controller.forward();
        _splitterController.state = SplitterState.playing;
        _splitterController.update();
        _splitterController.onPlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleIcon,
      padding: EdgeInsets.zero,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _controller,
          // color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
