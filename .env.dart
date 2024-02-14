import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';
import '../.env.dart' as env;

Future<FirebaseApp> myFirebaseApp() {
  return FirebaseApp.configure(
    name: env.firebaseName,
    options: FirebaseOptions(
      googleAppID: Platform.isIOS ? env.iosGoogleAppID : env.androidGoogleAppID,
      gcmSenderID: env.gcmSenderID,
      apiKey: env.apiKey,
      projectID: env.projectID,
    ),
  );
}