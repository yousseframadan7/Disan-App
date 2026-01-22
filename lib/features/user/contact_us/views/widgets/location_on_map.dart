// ignore_for_file: library_private_types_in_public_api

import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/contact_us/views/widgets/full_map_page.dart';

class LocationOnMap extends StatefulWidget {
  const LocationOnMap({super.key});

  @override
  _LocationOnMapState createState() => _LocationOnMapState();
}

class _LocationOnMapState extends State<LocationOnMap> {
  gm.GoogleMapController? mapController;
  final gm.LatLng companyLocation = const gm.LatLng(26.2537216, 31.9913984);
  bool isMapLoaded = false;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.02,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Text(
                  LocaleKeys.our_location_on_map.tr(),
                  style: AppTextStyles.title18PrimaryColorW700,
                ),
              ),
              Container(
                height: SizeConfig.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      gm.GoogleMap(
                        initialCameraPosition: gm.CameraPosition(
                          target: companyLocation,
                          zoom: 15,
                        ),
                        markers: {
                           gm.Marker(
                            markerId: gm.MarkerId(LocaleKeys.dakahlya_center.tr()),
                            position: gm.LatLng(26.2537216, 31.9913984),
                            infoWindow: gm.InfoWindow(title: 'Al Rayan for Electrical Tools Maintenance'),
                          ),
                        },
                        onMapCreated: (controller) {
                          setState(() {
                            mapController = controller;
                            isMapLoaded = true;
                          });
                        },
                        zoomControlsEnabled: false,
                      ),
                      if (!isMapLoaded)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.04,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                      size: SizeConfig.width * 0.05,
                    ),
                    SizedBox(width: SizeConfig.width * 0.02),
                    Expanded(
                      child: Text(
                        'Area near Assiut, Egypt',
                        style: AppTextStyles.title14Black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FullMapPage(),
                          ),
                        );
                      },
                      child: Text(
                        'View Location',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

