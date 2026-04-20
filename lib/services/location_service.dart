import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:battery_plus/battery_plus.dart';

class LocationService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Battery _battery = Battery();

  Future<void> updateLocation(String uid, double lat, double lng) async {
    int batteryLevel = await _battery.batteryLevel;
    await _firestore.collection('Users').doc(uid).update({
      'location': {
        'latitude': lat,
        'longitude': lng,
        'batteryLevel': batteryLevel,
        'updatedAt': FieldValue.serverTimestamp()
      }
    });
  }

  Stream<DocumentSnapshot> listenToPartner(String partnerUid) {
    return _firestore.collection('Users').doc(partnerUid).snapshots();
  }
}
