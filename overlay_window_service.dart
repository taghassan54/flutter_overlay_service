import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay/overlays/true_caller_overlay.dart';

class OverlayWindowService {
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? latestMessageFromOverlay;

  void init() {
   try{
     if (homePort != null) return;
     final res = IsolateNameServer.registerPortWithName(
       _receivePort.sendPort,
       _kPortNameHome,
     );
     log("$res: OVERLAY");
     _receivePort.listen((message) {
       log("message from OVERLAY: $message");

       latestMessageFromOverlay = 'Latest Message From Overlay: $message';
     });
   }catch(e){
     log(e.toString());
   }
  }

  // Check Permission
  Future<bool> isPermissionGranted() async {
    final status = await FlutterOverlayWindow.isPermissionGranted();
    log("Is Permission Granted: $status");
    return status;
  }

  // Request Permission
  Future<bool?> requestPermission() async {
    final bool? status = await FlutterOverlayWindow.requestPermission();
    log("status: $status");
    return status;
  }

  // Show Overlay
  showOverlay() async {
    try{
      log("isActive: ${(await FlutterOverlayWindow.isActive())}");
      if (await FlutterOverlayWindow.isActive()) return;
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "X-SLAYER",
        overlayContent: 'Overlay Enabled',
        flag: OverlayFlag.defaultFlag,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
        height: (400).toInt(),
        width: WindowSize.matchParent,
        startPosition: const OverlayPosition(0, 0),
      );
    }catch(e){
      log("$e");
    }
  }

  //Is Active
  Future<bool> isActive() async {
    final status = await FlutterOverlayWindow.isActive();
    log("Is Active?: $status");
    return status;
  }

  // Update Overlay
  resizeOverlay() async {
    await FlutterOverlayWindow.resizeOverlay(
      WindowSize.matchParent,
      (400).toInt(),
      false,
    );
  }

// Close Overlay
  Future<bool?> closeOverlay() => FlutterOverlayWindow.closeOverlay();

// Send message to overlay
  sendToOverlay({String? message}) {
    homePort ??= IsolateNameServer.lookupPortByName(_kPortNameOverlay);
    homePort?.send(message);
  }

// Get overlay position
  Future<OverlayPosition> getOverlayPosition() async =>
      await FlutterOverlayWindow.getOverlayPosition();

  Future<bool?> moveOverlay({double x = 0, double y = 0}) async =>
      await FlutterOverlayWindow.moveOverlay(
        OverlayPosition(x, y),
      );
}
