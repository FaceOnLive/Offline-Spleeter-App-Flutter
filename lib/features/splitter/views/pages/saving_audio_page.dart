import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app/views/dialogs/success_dialog.dart';
import '../../../home/views/pages/home_page.dart';
import '../../controllers/splitter_controller.dart';

class SavingAudioPage extends StatefulWidget {
  const SavingAudioPage({
    Key? key,
    required this.thePath,
  }) : super(key: key);

  final String thePath;

  @override
  State<SavingAudioPage> createState() => _SavingAudioPageState();
}

class _SavingAudioPageState extends State<SavingAudioPage> {
  final _controller = Get.find<SplitterController>();

  bool isSavingAudio = true;
  Future<void> saveThisAudio() async {
    // await Future.delayed(const Duration(seconds: 2));
    await _controller.saveThisAudio();
    isSavingAudio = false;
    setState(() {});
    Get.dialog(
      SuccessDialog(
          title: 'Export Done',
          message:
              'The Song has been exported successfully to \n ${widget.thePath}'),
    );
    Get.offAll(() => const HomePage());
  }

  @override
  void initState() {
    super.initState();
    saveThisAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Saving Audio...')
          ],
        ),
      ),
    );
  }
}
