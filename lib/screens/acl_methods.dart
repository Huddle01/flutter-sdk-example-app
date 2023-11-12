import 'package:flutter/material.dart';
import 'package:huddle01_flutter_client/huddle_client.dart';

class ACLMethods extends StatefulWidget {
  const ACLMethods({super.key, required this.huddleClient});
  final HuddleClient huddleClient;

  @override
  State<ACLMethods> createState() => _ACLMethodsState();
}

class _ACLMethodsState extends State<ACLMethods> {
  final TextEditingController peerIdController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'ACL',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: peerIdController,
            decoration: const InputDecoration(
              hintText: "Enter Peer Id:",
            ),
          ),
        ),
        TextButton(
          child: const Text('Change Peer Role'),
          onPressed: () {
            if (peerIdController.value.text.isNotEmpty) {
              widget.huddleClient
                  .changePeerRole(peerIdController.value.text.trim(), "host");
            } else {
              print("Enter Peer Id");
            }
          },
        ),
        TextButton(
          child: const Text('Kick Peer'),
          onPressed: () {
            if (peerIdController.value.text.isNotEmpty) {
              widget.huddleClient.kickPeer(peerIdController.value.text.trim());
            } else {
              print("Enter Peer Id");
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: displayNameController,
            decoration: const InputDecoration(
              hintText: "Enter Display Name:",
            ),
          ),
        ),
        TextButton(
          child: const Text('Set Display Name'),
          onPressed: () {
            if (displayNameController.value.text.isNotEmpty) {
              widget.huddleClient.setDisplayName(
                displayNameController.value.text.trim(),
              );
            } else {
              print("Enter Display Name");
            }
          },
        ),
        TextButton(
          child: const Text('Change Avatar Url'),
          onPressed: () {
            widget.huddleClient.changeAvatarUrl(
              'https://twinfinite.net/wp-content/uploads/2022/04/avatar_the_last_airbender_image.jpg?w=1200',
            );
          },
        ),
        TextButton(
          child: const Text('Send Data'),
          onPressed: () {
            widget.huddleClient.sendData('*', "Hello Huddle01!");
          },
        ),
        TextButton(
          child: const Text('Lock Room'),
          onPressed: () {
            widget.huddleClient.changeRoomControls("roomLocked", true);
          },
        ),
        TextButton(
          child: const Text('Unlock Room'),
          onPressed: () {
            widget.huddleClient.changeRoomControls("roomLocked", false);
          },
        ),
        TextButton(
          child: const Text('Lock Audio'),
          onPressed: () {
            widget.huddleClient.changeRoomControls("audioLocked", true);
          },
        ),
        TextButton(
          child: const Text('Unlock Audio'),
          onPressed: () {
            widget.huddleClient.changeRoomControls("audioLocked", false);
          },
        ),
        TextButton(
          child: const Text('Admit Peer'),
          onPressed: () {
            List lobbyPeers = widget.huddleClient.lobbyPeers;
            String admitFirstPeer = lobbyPeers[0]['peerId'];
            widget.huddleClient.admitPeer([admitFirstPeer]);
          },
        ),
        TextButton(
          child: const Text('Deny Peer'),
          onPressed: () {
            List lobbyPeers = widget.huddleClient.lobbyPeers;
            String denyFirstPeer = lobbyPeers[0]['peerId'];
            widget.huddleClient.denyPeer([denyFirstPeer]);
          },
        ),
      ],
    );
  }
}
