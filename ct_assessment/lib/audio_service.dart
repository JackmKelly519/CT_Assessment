import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _selectPlayer = AudioPlayer();
  final AudioPlayer _deselectPlayer = AudioPlayer();


  Future<void> playSelectSound() async {
    try {
      await _selectPlayer.play(AssetSource('sounds/select.mp3'));
    } catch (e) {
      log('Error playing select sound: $e');
    }
  }

  Future<void> playDeselectSound() async {
    try {
      await _deselectPlayer.stop();
      await _deselectPlayer.play(AssetSource('sounds/deselect.mp3'));
    } catch (e) {
      log('Error playing deselect sound: $e');
    }
  }

  void dispose() {
    _selectPlayer.dispose();
    _deselectPlayer.dispose();
  }
}
