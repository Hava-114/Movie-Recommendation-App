import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:movie_app/view/settings.dart';
import 'package:provider/provider.dart';
import 'view_models/login_view.dart';
import 'view_models/home_view.dart';
import 'view/login.dart';
import 'view/movie.dart';
import 'view/profile.dart';
import 'view/Explore.dart';
import 'firebase_option.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized for web');
  } else {
    // On non-web platforms, the native options are usually read from google-services.json
    await Firebase.initializeApp();
    debugPrint('Firebase initialized for native');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginView()),
        ChangeNotifierProvider(create: (_) => MovieView()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          },
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 58, 33, 82),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple))),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme(brightness: Brightness.dark, primary: Colors.purple, onPrimary: Colors.white, secondary: Colors.black , onSecondary: Colors.white, error: Colors.black, onError: Colors.white,surface: Colors.black,onSurface: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.purple,         // Label and icon color when selected
  unselectedItemColor: Colors.purple,       // Icon color when unselected
  showSelectedLabels: true,                 // Show label only for selected item
  showUnselectedLabels: false,              // Hide labels for unselected items
  type: BottomNavigationBarType.fixed, 
        )
        ),
      title: 'Movie App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context)=>SettingsScreen(),
        '/explore': (context)=>ExplorePage(),
      },
    );
  }
}
