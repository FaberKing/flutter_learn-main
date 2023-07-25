import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../widgets/location_mark_widget.dart';

class MapLocationPage extends StatefulWidget {
  final Map? loc;
  const MapLocationPage({super.key, this.loc});

  @override
  State<MapLocationPage> createState() => _MapLocationPageState();
}

class _MapLocationPageState extends State<MapLocationPage> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late LatLng latLngLocation;

  late GoogleMapController mapController;

  Set<Marker> markers = {};

  MapType selectedMapType = MapType.normal;

  geo.Placemark? placemark;
  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        leading: IconButton(
          onPressed: () => context.pop(latLngLocation),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Center(
        child: Stack(children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              zoom: 18,
              target: widget.loc == null
                  ? dicodingOffice
                  : LatLng(
                      widget.loc!['lat'],
                      widget.loc!['lon'],
                    ),
            ),
            mapType: selectedMapType,
            markers: markers,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
            onMapCreated: (controller) async {
              final info = await geo.placemarkFromCoordinates(
                widget.loc == null
                    ? dicodingOffice.latitude
                    : widget.loc!['lat'],
                widget.loc == null
                    ? dicodingOffice.longitude
                    : widget.loc!['lon'],
              );

              final place = info[0];
              final street = place.street!;
              final address =
                  '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

              setState(() {
                placemark = place;
              });

              defineMarker(
                  widget.loc == null
                      ? dicodingOffice
                      : LatLng(
                          widget.loc!['lat'],
                          widget.loc!['lon'],
                        ),
                  street,
                  address);

              setState(() {
                mapController = controller;
              });
            },
            onLongPress: (LatLng latLng) =>
                widget.loc == null ? onLongPressGoogleMap(latLng) : null,
          ),
          Positioned(
            bottom: 110,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: "zoom-in",
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.small(
                  heroTag: "zoom-out",
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton.small(
              heroTag: 'map_mode',
              onPressed: null,
              child: PopupMenuButton<MapType>(
                onSelected: (MapType item) {
                  setState(() {
                    selectedMapType = item;
                  });
                },
                offset: const Offset(0, 54),
                icon: const Icon(Icons.layers_outlined),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<MapType>>[
                  const PopupMenuItem<MapType>(
                    value: MapType.normal,
                    child: Text('Normal'),
                  ),
                  const PopupMenuItem<MapType>(
                    value: MapType.satellite,
                    child: Text('Satellite'),
                  ),
                  const PopupMenuItem<MapType>(
                    value: MapType.terrain,
                    child: Text('Terrain'),
                  ),
                  const PopupMenuItem<MapType>(
                    value: MapType.hybrid,
                    child: Text('Hybrid'),
                  ),
                ],
              ),
            ),
          ),
          widget.loc == null
              ? Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: 'my_loc',
                    child: const Icon(Icons.my_location),
                    onPressed: () => onMyLocationButtonPress(),
                  ),
                )
              : const SizedBox.shrink(),
          if (placemark == null)
            const SizedBox.shrink()
          else
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: PlacemarkWidget(
                placemark: placemark!,
              ),
            ),
        ]),
      ),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        log("Location services is not available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
    });
    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 18),
      ),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    latLngLocation = latLng;
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
