import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseOptions AppSetting() {
  WidgetsFlutterBinding.ensureInitialized();

  return FirebaseOptions(
    apiKey: 'AIzaSyAPRY2EJMJHD7O_LLnoDBfOH__QgmedHVs',
    appId: '1:871790315949:web:76b59ac25d8906db6db924',
    messagingSenderId: '871790315949',
    projectId: 'zutomayocard-6280a',
    storageBucket: 'zutomayocard-6280a.appspot.com',
  );
}
