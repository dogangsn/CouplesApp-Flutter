import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(41.0082, 28.9784); // Istanbul
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // json string ile darkMapStyle uygulanabilir
    _setupJointMarker();
  }

  void _setupJointMarker() {
      // In a real Flutter app, we would use a package like 'custom_info_window' or 
      // convert a Widget to a BitmapDescriptor using RepaintBoundary logic here.
      // For scaffold purposes, we simulate adding the joint marker:
      setState(() {
         _markers.add(
            Marker(
               markerId: const MarkerId('joint_pill'),
               position: _center,
               // icon: generatedBitmapDescriptor
            )
         );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          ),

          // Temsili Birleşik Harita Pini (UI Overlay Olarak Ortada)
          Center(
             child: _buildJointPillMockup(),
          ),
          
          // Info Bottom Sheet Placeholder
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: const BoxDecoration(
                color: Color(0xFF1a1024),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: const Column(
                children: [
                   Text("Zarif Bilgi Paneli", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                   SizedBox(height: 15),
                   ListTile(
                     leading: CircleAvatar(backgroundColor: AppColors.secondary, child: Text("🐼", style: TextStyle(fontSize: 24))),
                     title: Text("Eşiniz", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                     subtitle: Text("Şu an çevrimiçi ve size çok yakın.", style: TextStyle(color: AppColors.textMuted)),
                     trailing: Icon(Icons.battery_full, color: Colors.green),
                   )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJointPillMockup() {
      // Bu widget RepaintBoundary ile resme çevrilip GoogleMap Marker Icon'una beslenebilir.
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             // Hearts
             Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Transform.rotate(angle: -0.2, child: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20)),
                   Transform.rotate(angle: 0.1, child: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 26)),
                ]
             ),
             // Pill Box
             Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                   color: const Color(0xFFb395ff),
                   borderRadius: BorderRadius.circular(40)
                ),
                child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                      Container(
                         width: 50, height: 50,
                         decoration: const BoxDecoration(color: Color(0xFFf9d689), shape: BoxShape.circle),
                         alignment: Alignment.center,
                         child: const Text("🦁", style: TextStyle(fontSize: 32)),
                      ),
                      const SizedBox(width: 4),
                      Container(
                         width: 50, height: 50,
                         decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                         alignment: Alignment.center,
                         child: const Text("🐼", style: TextStyle(fontSize: 32)),
                      )
                   ]
                )
             ),
             // Tail
             Transform.translate(
               offset: const Offset(0, -10),
               child: Transform.rotate(
                  angle: 3.1415 / 4, // 45 deg
                  child: Container(
                     width: 20, height: 20,
                     decoration: const BoxDecoration(
                        color: Color(0xFFb395ff),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5))
                     )
                  )
               ),
             )
          ]
      );
  }
}
