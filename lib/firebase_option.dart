import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web; // for Flutter Web
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB0XgcaVhMopBt8LQPLNB6MXxw8he1zE1Y",
    authDomain: "login-c7b33.firebaseapp.com",
    projectId: "login-c7b33",
    storageBucket: "login-c7b33.firebasestorage.app",
    messagingSenderId: "254664931300",
    appId: "1:254664931300:web:a4dcaca7157a5a3a87b9f1",
    measurementId: "G-ZLL95NC1ZJ"
  );
}