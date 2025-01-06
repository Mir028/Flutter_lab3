import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/joke_types_screen.dart';
import 'screens/random_joke_screen.dart';
import 'firebase_options.dart';  // Import generated Firebase configuration
import 'package:firebase_messaging/firebase_messaging.dart';

void setupNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Побарајте дозвола за нотификации
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Корисникот дозволи нотификации.');
  } else {
    print('Корисникот одби нотификации.');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: JokeTypesScreen(),
    );
  }
}
