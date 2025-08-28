import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:check_location/location_helper.dart';
import 'package:check_location/location_service_controller.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Banner(
        message: 'Geo Location',
        location: BannerLocation.topEnd,
        child: const FinalView(),
      ),
    );
  }
}

/// Main screen of the app
class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  final LocationHelper locationHelper = LocationHelper();

  String userLocation = 'No data';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  /// Initial setup: request permissions and get location
  Future<void> initialize() async {
    await requestPermissions();
    await getLocation();
  }

  /// Request location permissions
  Future<void> requestPermissions() async {
    final status = await Permission.locationAlways.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  /// Fetch user's current location
  Future<void> getLocation() async {
    setState(() => _isLoading = true);

    final locationData = await locationHelper.getUserLocation();

    setState(() {
      if (locationData != null) {
        userLocation =
            'Latitude: ${locationData['latitude']}, Longitude: ${locationData['longitude']}\n'
            'City: ${locationData['city']}, Country: ${locationData['country']}\n'
            'Address: ${locationData['address']}';
      } else {
        userLocation = 'Location not found';
      }

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Location'),
      ),
      body: Center(
        child: _isLoading
            ? const CupertinoActivityIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userLocation,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: getLocation,
                    child: const Text('Refresh Location'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      LocationServiceController.startService();
                    },
                    child: const Text("Start Background Location"),
                  ),
                ],
              ),
      ),
    );
  }
}
