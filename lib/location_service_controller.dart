import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LocationServiceController {
  static const _channel = MethodChannel('com.example.location_tracker_app/location_service');

  static Future<void> startService() async {
    try {
      final result = await _channel.invokeMethod('startService');
      if (kDebugMode) {
        print(result);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error starting service: $e");
      }
    }
  }
}
