import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:check_location/main_sub.dart';
import 'location_callback_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundLocator.initialize();
  runApp(MyApp());
}

void startLocationService() {
  BackgroundLocator.registerLocationUpdate(
    LocationCallbackHandler.callback,
    initCallback: LocationCallbackHandler.initCallback,
    disposeCallback: LocationCallbackHandler.disposeCallback,
    iosSettings: IOSSettings(accuracy: LocationAccuracy.NAVIGATION),
    androidSettings: AndroidSettings(
      accuracy: LocationAccuracy.NAVIGATION,
      interval: 2,
      distanceFilter: 10,
      client: LocationClient.google,
      androidNotificationSettings: AndroidNotificationSettings(
        notificationChannelName: 'Location tracking',
        notificationTitle: 'Tracking location',
        notificationMsg: 'App running in background',
        notificationBigMsg:
            'Background location tracking is active',
        notificationIcon: '',
      ),
    ),
  );
}
