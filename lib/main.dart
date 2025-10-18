import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/splash_screen/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:toastification/toastification.dart';

import 'services/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
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
  initPlatForm() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.none);

    OneSignal.initialize('appId'); //---------------------ADD ONESIGNAL APP ID
    OneSignal.User.pushSubscription.optIn();
    await OneSignal.consentRequired(true);

    OneSignal.Notifications.addForegroundWillDisplayListener(
        (OSNotificationWillDisplayEvent event) {
      /// preventDefault to not display the notification
      event.preventDefault();

      /// Do async work
      /// notification.display() to display after preventing default
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((OSNotificationClickEvent result) {
      ///TODO:
    });
  }

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
    initPlatForm();
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
