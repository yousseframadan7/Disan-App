import 'package:record/record.dart';

import 'package:record/record.dart';

final record = AudioRecorder();

Future<String?> startRecord() async {
  if (await record.hasPermission()) {
    await record.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: 'voice_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    return 'recording';
  }
  return null;
}

Future<String?> stopRecord() async {
  final path = await record.stop();
  return path;
}
