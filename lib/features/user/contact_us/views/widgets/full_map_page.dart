// ignore_for_file: library_private_types_in_public_api

import 'package:disan/core/helper/show_snack_bar.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'package:geolocator/geolocator.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';

class FullMapPage extends StatefulWidget {
  const FullMapPage({super.key});

  @override
  _FullMapPageState createState() => _FullMapPageState();
}

class _FullMapPageState extends State<FullMapPage> {
  gm.GoogleMapController? mapController;
  final gm.LatLng companyLocation = gm.LatLng(26.2537216, 31.9913984);
  gm.LatLng? currentLocation;
  bool isMapLoaded = false;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(title: LocaleKeys.enable_location_services.tr());
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(title: LocaleKeys.location_permission_denied.tr());
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          title: LocaleKeys.location_permission_permanently_denied.tr());
      return false;
    }

    return true;
  }

  Future<void> _focusOnLocations() async {
    bool hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentLocation = gm.LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${LocaleKeys.error_getting_location.tr()} : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Map'),
      ),
      body: Stack(
        children: [
          gm.GoogleMap(
            initialCameraPosition: gm.CameraPosition(
              target: companyLocation,
              zoom: 15,
            ),
            markers: {
              gm.Marker(
                markerId: gm.MarkerId(LocaleKeys.hekaya_accessories.tr()),
                position: gm.LatLng(26.2537216, 31.9913984),
                infoWindow:
                    gm.InfoWindow(title: LocaleKeys.hekaya_accessories.tr()),
              ),
              if (currentLocation != null)
                gm.Marker(
                  markerId: gm.MarkerId(LocaleKeys.current_location.tr()),
                  position: currentLocation!,
                  infoWindow:
                      gm.InfoWindow(title: LocaleKeys.current_location.tr()),
                  icon: gm.BitmapDescriptor.defaultMarkerWithHue(
                      gm.BitmapDescriptor.hueBlue),
                ),
            },
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
                isMapLoaded = true;
                _focusOnLocations();
              });
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
          ),
          if (!isMapLoaded)
            Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
