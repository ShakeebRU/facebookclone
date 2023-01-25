import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
    required this.room,
  });

  final types.Room room;
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final AgoraClient client;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    client = AgoraClient(
      enabledPermission: [Permission.camera, Permission.microphone],
      agoraConnectionData: AgoraConnectionData(
        appId: "264787d9f9364227b55bb3c0a55489b5",
        channelName: widget.room.id,
        username: "user",
      ),
    );
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora VideoUIKit'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.grid,
              enableHostControls: true,
              showAVState: true,
              showNumberOfUsers: true,
              // Add this to enable host controls
            ),
            AgoraVideoButtons(
              autoHideButtons: true,
              client: client,
            ),
          ],
        ),
      ),
    );
  }
}
