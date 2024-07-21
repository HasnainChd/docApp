import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medi_app/consts/images.dart';
import 'package:medi_app/views/google_map/user_location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

  void _loadCurrentLocation() async {
    try {
      currentPosition = await locationService.determinePosition();
      setState(() {
        // Add a marker or blue filled circle at the user's current location
        _markers.add(
          Marker(
            markerId: MarkerId('currentPosition'),
            position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });
      mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(currentPosition!.latitude, currentPosition!.longitude),
      ));
      _fetchNearbyDoctors();
    } catch (e) {
      // Handle errors here
      print(e);
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
                snippet: 'Rating: ${data['docRating']} | Distance: $distanceString km',
              ),
              icon: await _getCustomMarker(AppAssets.signUp), // Custom marker for doctor
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
              color: Colors.blue,
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

  Future<BitmapDescriptor> _getCustomMarker(String asset) async {
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      asset,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Nearby Doctors'),
      ),
      body: currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: currentPosition != null
              ? LatLng(currentPosition!.latitude, currentPosition!.longitude)
              : LatLng(0, 0), // Fallback to a default location
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
