
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task/utils/colors.dart';
import 'package:task/utils/text_style.dart';
import 'package:task/widgets/custom_button.dart';
import '../HomeScreen/home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _isLoading = false;

  Future<String> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar("Location services are disabled.");
      setState(() => _isLoading = false);
      return "Location services are disabled.";
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar("Location permissions are denied.");
        setState(() => _isLoading = false);
        return "Location permissions are denied.";
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar("Location permissions are permanently denied.");
      setState(() => _isLoading = false);
      return "Location permissions are permanently denied.";
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = "${place.thoroughfare}, ${place.locality}, ${place.country}";
        return address;
      }
    } catch (e) {
      // Handle potential geocoding errors
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    return "Lat: ${position.latitude}, Lon: ${position.longitude}";
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 124),
              Container(
                alignment: Alignment.centerLeft,
                child: headingTwo(
                  data: 'Welcome! Your\nPersonalized Alarm',
                  fontWeight: FontWeight.w600,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              headingThree(
                data: 'Allow us to sync your sunset alarm\nbased on your location.',
                textColor: AppColors.whiteColor,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 360,
                height: 309,
                child: Image.asset(
                  'assets/images/morning_picture.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              _isLoading
                  ? Center(child: CircularProgressIndicator(color: AppColors.whiteColor))
                  : CustomButton(
                text: 'Use Current Location',
                onPressed: () async {
                  String locationAddress = await _getCurrentLocation();
                  if (!locationAddress.contains("denied") && !locationAddress.contains("disabled")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(selectedLocation: locationAddress),
                      ),
                    );
                  }
                },
                color: AppColors.homeButtonColor,
                borderRadius: 8,
                suffixIcon: Icons.location_on,
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: 'Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                color: AppColors.homeButtonColor,
                borderRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}