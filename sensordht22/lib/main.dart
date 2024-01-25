import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sensordht22/Myapp.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBkTzXsrqmAFNVofjIwIF0jIQqQd65evls",
      appId: "1:345614720476:android:c45629a6393a5fb6bb0319",
      messagingSenderId: "345614720476",
      projectId: "sensordht22-70d71",
      databaseURL:
          "https://sensordht22-70d71-default-rtdb.asia-southeast1.firebasedatabase.app",
    ),
  );
  runApp(const MyApp());
}
