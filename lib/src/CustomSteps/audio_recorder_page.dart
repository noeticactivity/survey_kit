import 'dart:io';
import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecorderPage extends StatefulWidget {
  final FlutterSoundRecorder? recorder;
  final FlutterSoundPlayer? player;
  const AudioRecorderPage({
    Key? key,
    required this.recorder,
    required this.player,
  }) : super(key: key);

  @override
  AudioRecorderPageState createState() => AudioRecorderPageState();
}

class AudioRecorderPageState extends State<AudioRecorderPage>
    with AutomaticKeepAliveClientMixin {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  StreamSubscription? _timerSubscription;
  String _timerStr =
      ''; //'00:00:00'; //FIXME: Localize the string we we include a length maximum
  String _currentFilePath = '', _recordedFilePath = '';
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _recorderInit = false, _playerInit = false;

  StreamController<Food> _recordingStreamController = StreamController<Food>();
  Stream<Food> get recordingStream => _recordingStreamController.stream;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await initRecorder();
    initPlayer();
  }

  @override
  void dispose() {
    if (_recorder != null) {
      _recorder!.closeRecorder();
      _recorder = null;
    }
    if (_player != null) {
      _player!.closePlayer();
      _player = null;
    }
    _timerSubscription?.cancel();
    _recordingStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // AppBar(
        //   title: Text('Recorder'),
        //   centerTitle: true,
        // ),
        Container(
          padding: const EdgeInsets.all(8.0), //.copyWith(top: kToolbarHeight),
          // padding: const EdgeInsets.all(40.0), //.copyWith(top: kToolbarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //FIXME: Fix this Audio Part
              // StreamBuilder<RecordingDisposition>(
              //   stream:
              //       _recorder?.onProgress, // Add the null-aware access operator
              //   builder: (context, snapshot) {
              //     final duration = snapshot.hasData
              //         ? snapshot.data!.duration
              //         : Duration.zero;
              //     // Rest of your code
              //     return Text('${duration}');
              //   },
              // ),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                child: Text(
                  _timerStr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1 / 1,
                child: AvatarGlow(
                  animate: _isRecording || _isPlaying,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 90,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: RawMaterialButton(
                      fillColor: Theme.of(context).primaryColor,
                      shape: CircleBorder(),
                      child: centerIconFromState(),
                      onPressed: () {
                        determineTapLogic();
                      },
                    ),
                  ),
                ),
              ),
              // If you debug and press play with track not set don't worry about the logs it is intended and app won't crash either.
              //FIXME: ADD SOUND PLAYER
              //SoundPlayerUI.fromLoader((context) => loadTrack(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget centerIconFromState() {
    if (_recordedFilePath != '') {
      return Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 50,
      );
    } else {
      return _isRecording
          ? SpinKitThreeBounce(color: Colors.white)
          : Icon(
              Icons.mic_none_rounded,
              color: Colors.white,
              size: 50,
            );
    }
  }

  void determineTapLogic() {
    if (_recordedFilePath != '' && _recorder!.isStopped) {
      play();
    } else if (_recorder!.isStopped) {
      startRecording();
    } else {
      stopRecording();
    }
  }

  Future<void> initRecorder() async {
    var status = await Permission.microphone.request();
    debugPrint('Microphone permission status: $status');
    if (status == PermissionStatus.granted) {
      _recorder = widget.recorder;
      await _recorder!
          .openRecorder()
          .then((value) => this._recorderInit = true);
      _recorder!.setSubscriptionDuration(const Duration(milliseconds: 500));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Microphone permission not granted'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> initPlayer() async {
    _player = widget.player;
    await _player!.openPlayer().then((value) => this._playerInit = true);
  }

  bool get isRecorderInit => _recorderInit;
  bool get isPlayerInit => _playerInit;

  Future<void> startRecording() async {
    if (!_recorderInit) return;
    final _folderPath = await getApplicationDocumentsDirectory();
    await Permission.storage.request().then((status) async {
      if (status.isGranted) {
        if (!(await _folderPath.exists())) {
          await _folderPath.create(recursive: true);
        }
        final _fileName =
            'DEMO_${DateTime.now().millisecondsSinceEpoch.toString()}.aac';
        _currentFilePath = '${_folderPath.path}$_fileName';
        setState(() {});
        _recorder!
            .startRecorder(toFile: _currentFilePath)
            //toStream: _recordingStreamController.sink)
            .then((value) {
          setState(() {
            this._isRecording = true;
          });
          startTimer();
        });
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage permission not granted'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void startTimer() {
    //FIXME: Make a 1 minute maximum
    //print("****************** startTimer ${_recorder!.onProgress!}");
    if (_isRecording) {
      _timerSubscription = _recorder!.onProgress!.listen((event) {
        final currentDuration = event.duration;
        debugPrint("****************** currentDuration ${currentDuration}");
        final hourStr = ((currentDuration.inHours / (60 * 60)) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        final minStr = ((currentDuration.inMinutes / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        final secStr =
            (currentDuration.inSeconds % 60).floor().toString().padLeft(2, '0');
        //final durationStr = '$hourStr:$minStr:$secStr';
        final durationStr = '$minStr:$secStr';
        debugPrint("****************** durationStr ${durationStr}");
        setState(() {
          debugPrint("****************** timer setstate");
          _timerStr = durationStr;
        });
      });
    }
  }

  Future<void> stopRecording() async {
    //Add if we have the audio file, then change icon to Play and make Submit button clickable
    if (!_recorderInit) return;
    await _recorder!.stopRecorder().then((recordPath) {
      if (recordPath != null) {
        _timerSubscription?.cancel();
        _recordedFilePath = recordPath;
        setState(() {
          _timerStr = ''; //'00:00'; //FIXME: Localize this string
          _isRecording = false;
        });
      }
    });
  }

  // -------  Here is the code to playback a remote file -----------------------

  void play() async {
    await _player!.startPlayer(
        fromURI: _recordedFilePath,
        codec: Codec.mp3,
        whenFinished: () {
          setState(() {});
        });
    _isPlaying = true;
    setState(() {});
  }

//FIXME: Use something else to load the track from `recordPath`
  // Future<Track> loadTrack(BuildContext context) async {
  //   Trac
  //   Track track = Track();
  //   var file = File(_recordedFilePath);
  //   if (file.existsSync()) {
  //     track = Track(trackPath: file.path);
  //   }
  //   return track;
  // }
}
