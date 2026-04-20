import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? currentUserProfile;
  String? partnerUid;
  String? get myUid => _auth.currentUser?.uid;

  AuthService();

  Future<void> loginAndGetCode(Map<String, dynamic> profileData) async {
    UserCredential userCred = await _auth.signInAnonymously();
    String newUid = userCred.user!.uid;
    
    // Save to Firestore
    await _firestore.collection('Users').doc(newUid).set({
      'profile': profileData,
      'createdAt': FieldValue.serverTimestamp(),
    });

    currentUserProfile = profileData;
    notifyListeners();
  }

  Future<void> connectWithPartner(String code) async {
    // A simplified code connection (in dart)
    if (code.startsWith("BOT")) {
       partnerUid = 'bot_1';
    } else {
       // Search 'Users' collection snapshot where connection code matches
       partnerUid = code; 
    }
    notifyListeners();
  }
}
