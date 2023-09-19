import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:huddle01_flutter_client/data/value_notifiers.dart';
import 'package:huddle01_flutter_client/huddle_client.dart';

import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HuddleClient huddleClient = HuddleClient();

  String projectId = 'YOUR-PROJECT-ID';
  String roomId = 'YOUR-ROOM-ID';


  getPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }


  @override
  void initState() {
    getPermissions();
    huddleClient.huddleEventListeners();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // remote-stream
  RTCVideoRenderer? remoteRenderer;
  initilialize() async {
    remoteRenderer = RTCVideoRenderer();
    await remoteRenderer!.initialize();
    remoteRenderer!.srcObject = huddleClient.getFirstRemoteStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Huddle01 Flutter SDK Example'),
      ),
      body: Row(children: [
        Expanded(
            child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Text(
                  'Room',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  child: const Text('INITIALIZE'),
                  onPressed: () {
                    if (huddleClient.isInitializedCallable()) {
                      huddleClient.initialize(projectId);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('INITIALIZE -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('JOIN-LOBBY'),
                  onPressed: () {
                    if (huddleClient.isJoinLobbyCallable()) {
                      huddleClient.joinLobby(roomId);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('JOIN-LOBBY -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('JOIN-ROOM'),
                  onPressed: () {
                    if (huddleClient.isJoinRoomCallable()) {
                      huddleClient.joinRoom();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('JOIN-ROOM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('LEAVE-LOBBY'),
                  onPressed: () {
                    if (huddleClient.isLeaveLobbyCallable()) {
                      huddleClient.leaveLobby();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('LEAVE-LOBBY -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('LEAVE-ROOM'),
                  onPressed: () {
                    if (huddleClient.isleaveRoomCallable()) {
                      huddleClient.leaveRoom();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('LEAVE-ROOM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('END-ROOM'),
                  onPressed: () {
                    if (huddleClient.isEndRoomCallable()) {
                      huddleClient.endRoom();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('END-ROOM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                const Text(
                  'Audio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      huddleClient.enumerateMicDevices();
                    },
                    child: const Text("ENUMERATE MIC DEVICE")),
                TextButton(
                  child: const Text('FETCH AUDIO STREAM'),
                  onPressed: () {
                    if (huddleClient.isFetchAudioStreamCallable()) {
                      huddleClient.fetchAudioStream();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('FETCH AUDIO STREAM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('PRODUCE AUDIO'),
                  onPressed: () {
                    if (huddleClient.isProduceAudioCallable()) {
                      huddleClient.produceAudio(huddleClient.getAudioStream());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('PRODUCE AUDIO -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('STOP AUDIO STREAM'),
                  onPressed: () {
                    if (huddleClient.isStopAudioStreamCallable()) {
                      huddleClient.stopAudioStream();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('STOP AUDIO STREAM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text(
                    'STOP PRODUCING\nAUDIO',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (huddleClient.isStopProducingAudioCallable()) {
                      huddleClient.stopProducingAudio();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('STOP PRODUCTING AUDIO -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                const Text(
                  'Video',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      huddleClient.enumerateCamDevices();
                    },
                    child: const Text("ENUMERATE CAM DEVICE")),
                TextButton(
                  child: const Text('FETCH VIDEO STREAM'),
                  onPressed: () {
                    if (huddleClient.isFetchVideoStreamCallable()) {
                      huddleClient.fetchVideoStream();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('FETCH VIDEO STREAM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('PRODUCE VIDEO'),
                  onPressed: () {
                    if (huddleClient.isProduceVideoCallable()) {
                      huddleClient.produceVideo(huddleClient.getVideoStream());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('PRODUCE VIDEO -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('STOP VIDEO STREAM'),
                  onPressed: () {
                    if (huddleClient.isStopVideoStreamCallable()) {
                      huddleClient.stopVideoStream();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('STOP VIDEO STREAM -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: const Text('STOP PRODUCTING VIDEO'),
                  onPressed: () {
                    if (huddleClient.isStopProducingVideoCallable()) {
                      huddleClient.stopProducingVideo();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('STOP PRODUCTING VIDEO -> not callable yet'),
                        backgroundColor: Colors.red,
                        elevation: 4,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
              ],
            ),
          ],
        )),
        Expanded(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: roomState,
              builder: (ctx, val, _) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey.shade100),
                  child: Column(
                    children: [
                      Text(
                        "Room State\n ${val['roomState']}",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Local Stream",
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Container(
                  color: Colors.grey,
                  width: 500,
                  height: 250,
                  child: huddleClient.getRenderer() != null
                      ? RTCVideoView(
                          huddleClient.getRenderer()!,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        )
                      : null),
            ),
            TextButton(
              child: const Text(
                'Get Remote Stream',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                initilialize();
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Container(
                  color: Colors.grey,
                  width: 500,
                  height: 250,
                  child: huddleClient.getConsumers().isNotEmpty
                      ? RTCVideoView(
                          remoteRenderer!,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        )
                      : null),
            ),
          ],
        )),
      ]),
    );
  }
}
