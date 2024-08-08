import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medi_app/views/google_map/user_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Position? currentPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final LocationService locationService = LocationService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  // Function to determine gender based on doctor's name
  String determineGender(String name) {
    return name.endsWith('a') ? 'female' : 'male';
  }

  void _loadCurrentLocation() async {
    try {
      currentPosition = await locationService.determinePosition();
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('currentPosition'),
            position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(
              title: 'ME',
            ),
          ),
        );
      });
      mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(currentPosition!.latitude, currentPosition!.longitude),
      ));
      _fetchNearbyDoctors();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Handle errors here
    }
  }

  void _fetchNearbyDoctors() async {
    if (currentPosition == null) return;

    double userLat = currentPosition!.latitude;
    double userLng = currentPosition!.longitude;
    double radius = 10.0; // 10 km radius

    // Fetch doctors from Firestore
    QuerySnapshot querySnapshot = await firestore.collection('doctors').get();

    // Process markers and polylines
    Set<Marker> newMarkers = {};
    Set<Polyline> newPolylines = {};

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('latitude') && data.containsKey('longitude')) {
        double docLat = data['latitude'];
        double docLng = data['longitude'];

        // Calculate distance between user and doctor
        double distance = Geolocator.distanceBetween(userLat, userLng, docLat, docLng);
        String distanceString = (distance / 1000).toStringAsFixed(2); // Convert to km and format

        if (distance <= radius * 1000) { // Check if within radius
          // Add a marker for the doctor
          newMarkers.add(
            Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(docLat, docLng),
              infoWindow: InfoWindow(
                title: data['docName'],
                snippet: 'Distance: $distanceString km',
              ),
              icon: BitmapDescriptor.defaultMarker,
            ),
          );

          // Add a polyline between the user and the doctor
          newPolylines.add(
            Polyline(
              polylineId: PolylineId(doc.id),
              visible: true,
              points: [
                LatLng(userLat, userLng),
                LatLng(docLat, docLng),
              ],
              color: _getPolylineColor(doc.id),
              width: 2,
            ),
          );
        }
      }
    }

    // Update the state with the new markers and polylines
    setState(() {
      _markers.addAll(newMarkers);
      _polylines.addAll(newPolylines);
    });
  }

  Color _getPolylineColor(String docId) {
    // Generate a color based on the hash code of the docId
    int hash = docId.hashCode;
    int r = (hash & 0xFF0000) >> 16;
    int g = (hash & 0x00FF00) >> 8;
    int b = (hash & 0x0000FF);
    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Nearby Doctors'),
      ),
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentPosition!.latitude,
            currentPosition!.longitude,
          ),
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
