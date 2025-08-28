import 'dart:io';
import 'package:background_locator_2/location_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class LocationCallbackHandler {
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    if (kDebugMode) {
      print('*** Init callback: $params');
    }
  }

  static Future<void> disposeCallback() async {
    if (kDebugMode) {
      print('*** Dispose callback');
    }
  }

  static Future<void> callback(LocationDto locationDto) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/locations.txt');

    final log = '${DateTime.now()}: ${locationDto.latitude}, ${locationDto.longitude}\n';
    if (kDebugMode) {
      print(log);
    }
    file.writeAsStringSync(log, mode: FileMode.append);
  }
}
