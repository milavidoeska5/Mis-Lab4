import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ShowRouteScreen extends StatefulWidget {
  final double destinationLat;
  final double destinationLng;

  const ShowRouteScreen({Key? key, required this.destinationLat, required this.destinationLng})
      : super(key: key);

  @override
  _ShowRouteScreenState createState() => _ShowRouteScreenState();
}

class _ShowRouteScreenState extends State<ShowRouteScreen> {
  late GoogleMapController _mapController;
  LatLng? _currentLocation;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);

        _markers.add(Marker(
          markerId: MarkerId('current'),
          position: _currentLocation!,
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
        _markers.add(Marker(
          markerId: MarkerId('destination'),
          position: LatLng(widget.destinationLat, widget.destinationLng),
          infoWindow: InfoWindow(title: 'Exam Location'),
        ));

        // Add polyline
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: [
            _currentLocation!,
            LatLng(widget.destinationLat, widget.destinationLng),
          ],
          color: Colors.blue,
          width: 5,
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get current location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shortest Route'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _currentLocation!,
          zoom: 12.0,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
