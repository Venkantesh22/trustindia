import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/splash_screen/splash_screen.dart';
import 'package:toastification/toastification.dart';
import 'services/init.dart';
import 'main_firebase_options.dart' as main_config;
import 'secondary_firebase_options.dart' as second_config;

//   AppPackage Name = "com.saithiya.smart"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// 2. Use the alias to call the options
  await Firebase.initializeApp(
    options: main_config.DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Initialize the Secondary Project (Must have a unique name)
  await Firebase.initializeApp(
    name: 'SecondaryApp',
    options: second_config.DefaultFirebaseOptions.currentPlatform,
  );
  await Init().initialize();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('Current state = $state');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // initPlatForm();
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: CustomTheme.light,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
