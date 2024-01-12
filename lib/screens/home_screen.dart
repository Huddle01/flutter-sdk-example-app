import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle01_flutter_client.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/custom_snackbar.dart';
import 'acl_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String projectId = 'YOUR_PROJECT_ID';
  String roomId = 'YOUR_ROOM_ID';

  HuddleClient huddleClient = HuddleClient();

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
  initilializeRemoteStream() async {
    remoteRenderer = RTCVideoRenderer();
    await remoteRenderer?.initialize();
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
      body: Row(
        children: [
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
                        customSnackbar(
                            context, 'INITIALIZE -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('JOIN-LOBBY'),
                    onPressed: () {
                      if (huddleClient.isJoinLobbyCallable()) {
                        huddleClient.joinLobby(roomId);
                      } else {
                        customSnackbar(
                            context, 'JOIN-LOBBY -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('JOIN-ROOM'),
                    onPressed: () {
                      if (huddleClient.isJoinRoomCallable()) {
                        huddleClient.joinRoom();
                      } else {
                        customSnackbar(
                            context, 'JOIN-ROOM -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('LEAVE-LOBBY'),
                    onPressed: () {
                      if (huddleClient.isLeaveLobbyCallable()) {
                        huddleClient.leaveLobby();
                      } else {
                        customSnackbar(
                            context, 'LEAVE-LOBBY -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('LEAVE-ROOM'),
                    onPressed: () {
                      if (huddleClient.isleaveRoomCallable()) {
                        huddleClient.leaveRoom();
                      } else {
                        customSnackbar(
                            context, 'LEAVE-ROOM -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('END-ROOM'),
                    onPressed: () {
                      if (huddleClient.isEndRoomCallable()) {
                        huddleClient.endRoom();
                      } else {
                        customSnackbar(context, 'END-ROOM -> not callable yet');
                      }
                    },
                  ),
                  const Text(
                    'Audio',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  TextButton(
                    child: const Text('FETCH AUDIO STREAM'),
                    onPressed: () {
                      if (huddleClient.isFetchAudioStreamCallable()) {
                        huddleClient.fetchAudioStream();
                      } else {
                        customSnackbar(
                            context, 'FETCH AUDIO STREAM -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('PRODUCE AUDIO'),
                    onPressed: () {
                      if (huddleClient.isProduceAudioCallable()) {
                        huddleClient
                            .produceAudio(huddleClient.getAudioStream());
                      } else {
                        customSnackbar(
                            context, 'PRODUCE AUDIO -> not callable yet');
                      }
                    },
                  ),

                  TextButton(
                    child: const Text(
                      'STOP PRODUCING AUDIO',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (huddleClient.isStopProducingAudioCallable()) {
                        huddleClient.stopProducingAudio();
                      } else {
                        customSnackbar(context,
                            'STOP PRODUCING AUDIO -> not callable yet');
                      }
                    },
                  ),
                  const Text(
                    'Video',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  TextButton(
                    child: const Text(
                      'FETCH VIDEO STREAM',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (huddleClient.isFetchVideoStreamCallable()) {
                        huddleClient.fetchVideoStream();
                      } else {
                        customSnackbar(
                            context, 'FETCH VIDEO STREAM -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('PRODUCE VIDEO'),
                    onPressed: () {
                      if (huddleClient.isProduceVideoCallable()) {
                        huddleClient
                            .produceVideo(huddleClient.getVideoStream());
                      } else {
                        customSnackbar(
                            context, 'PRODUCE VIDEO -> not callable yet');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'STOP VIDEO STREAM',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (huddleClient.isStopVideoStreamCallable()) {
                        huddleClient.stopVideoStream();
                      } else {
                        customSnackbar(context, 'STOP VIDEO STREAM');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'STOP PRODUCING VIDEO',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (huddleClient.isStopProducingVideoCallable()) {
                        huddleClient.stopProducingVideo();
                      } else {
                        customSnackbar(context,
                            'STOP PRODUCTING VIDEO -> not callable yet');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // ACL METHODS
                  ACLMethods(huddleClient: huddleClient)
                ],
              ),
            ],
          )),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
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
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ValueListenableBuilder(
                      valueListenable: peersList,
                      builder: (ctx, val, _) {
                        return Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blueGrey.shade100),
                          child: Column(
                            children: [
                              Text(
                                "Peers\n $val",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                      ),
                      child: const Text(
                        'Get Local Video Stream',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Container(
                          color: Colors.grey,
                          width: 500,
                          height: 250,
                          child: huddleClient.getLocalRenderer() != null
                              ? RTCVideoView(
                                  huddleClient.getLocalRenderer()!,
                                  objectFit: RTCVideoViewObjectFit
                                      .RTCVideoViewObjectFitCover,
                                )
                              : null),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                      ),
                      child: const Text(
                        'Get Remote Stream',
                        style: TextStyle(fontSize: 14),
                      ),
                      onPressed: () async {
                        await initilializeRemoteStream();
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Container(
                        color: Colors.grey,
                        width: 500,
                        height: 250,
                        child: huddleClient.getConsumers().isNotEmpty &&
                                remoteRenderer != null
                            ? RTCVideoView(
                                remoteRenderer!,
                                objectFit: RTCVideoViewObjectFit
                                    .RTCVideoViewObjectFitCover,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
