import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'package:flutter/material.dart';

class BackgroundGeoDetect extends StatefulWidget {
  const BackgroundGeoDetect({super.key});

  @override
  State<BackgroundGeoDetect> createState() => _BackgroundGeoDetectState();
}

class _BackgroundGeoDetectState extends State<BackgroundGeoDetect> {
  @override
  void initState() {
    super.initState();
    _initializeBackgroundGeolocation();
  }

  void _initializeBackgroundGeolocation() async {
    // Configure the plugin
    await bg.BackgroundGeolocation.ready(
      bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        geofenceModeHighAccuracy: true, // High accuracy for geofencing

        enableHeadless: true, // Enables headless mode for background tracking
        stopOnTerminate: false, // Continue tracking when the app is terminated
        startOnBoot: true, // Automatically start tracking on device boot

        distanceFilter: 5, // Time-based tracking (distance filter disabled)
        locationUpdateInterval: 10000, // Location update interval (10 seconds)
        fastestLocationUpdateInterval: 5000, // Fastest interval (5 seconds)

        debug: false, // Disable debug notifications
        isMoving: true, // Sets pace to prevent automatic stopping of tracking
        disableStopDetection: true, // Prevent automatic stopping of tracking
        stopTimeout: 0, // Disable automatic stop timeout
      ),
    );

       // Listen to location events
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      // Handle location updates
      print('Location received: ${location.coords.latitude}, ${location.coords.longitude}');
    });

    bg.BackgroundGeolocation.ready(bg.Config(
      enableHeadless: true,
      startOnBoot: true,
      stopOnTerminate: false
    ));
  }

  void _startTracking() async {
    await bg.BackgroundGeolocation.start();
    print('Tracking started');
  }

  void _stopTracking() async {
    await bg.BackgroundGeolocation.stop();
    print('Tracking stopped');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
