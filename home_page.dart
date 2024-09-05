import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay/overlay_window_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OverlayWindowService overlayWindowService=OverlayWindowService();
  @override
  void initState() {
    super.initState();
    overlayWindowService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: overlayWindowService.isPermissionGranted,
              child: const Text("Check Permission"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: overlayWindowService.requestPermission,
              child: const Text("Request Permission"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: overlayWindowService.showOverlay,
              child: const Text("Show Overlay"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: overlayWindowService.isActive,
              child: const Text("Is Active?"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () => overlayWindowService.sendToOverlay(message: "hello"),
              child: const Text("Update Overlay"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: overlayWindowService.closeOverlay,
              child: const Text("Close Overlay"),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed:() =>  overlayWindowService.sendToOverlay(message: 'Send to overlay: ${DateTime.now()}'),
              child: const Text("Send message to overlay"),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: overlayWindowService.getOverlayPosition,
              child: const Text("Get overlay position"),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () => overlayWindowService.moveOverlay,
              child: const Text("Move overlay position to (0, 0)"),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}