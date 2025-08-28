import 'package:check_location/bg_location_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

@pragma('vm:entry-point')
void headlessTask(bg.HeadlessEvent event) async {
  print('[HeadlessTask] - ${event.name}');
  
  switch (event.name) {
    case bg.Event.LOCATION:
      bg.Location location = event.event;
      print('Headless location received: ${location.coords.latitude}, ${location.coords.longitude}');
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = event.event;
      print('Headless motion change: ${location.isMoving}');
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = event.event;
      print('Headless geofence event: ${geofenceEvent.action}');
      break;
    case bg.Event.HEARTBEAT:
      bg.HeartbeatEvent heartbeatEvent = event.event;
      print('Headless heartbeat: ${heartbeatEvent.location?.coords.latitude}, ${heartbeatEvent.location?.coords.longitude}');
      break;
    default:
      print('Headless event: ${event.name}');
  }
}

void main() {
  runApp(const MyApp());
  
  // Register the headless task
  bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);
}

/// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackgroundGeoDetect(),
    );
  }
}

