import 'package:crypto_wallet/bloc/student.bloc.dart';
import 'package:crypto_wallet/bloc/student.state.dart';
import 'package:crypto_wallet/repositories/student.repo.dart';
import 'package:crypto_wallet/ui/auth/authentification.dart';
// import 'package:crypto_wallet/ui/details/components/body.dart';
import 'package:crypto_wallet/ui/home/components/body.dart';
import 'package:crypto_wallet/ui/home/home_screen.dart';
import 'package:crypto_wallet/ui/pages/professors.page.dart';
import 'package:crypto_wallet/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';

// import 'ui/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerLazySingleton(() => new ProfessorsRepository());

  // FirebaseMessaging.private(_firebaseMessagingBackgroundHandler)
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // super.initState();

  runApp(MyApp());
}

// @override
class MyApp extends StatelessWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String messageTitle = "Empty";
//   String notificationAlert = "alert";

//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   @override
//   void initState() {
//     // TODO: implement initState
//     void initState() {
//       FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//       // TODO: implement initState
//       // super.initState();

//       _firebaseMessaging.configure(
//         onMessage: (message) async {
//           setState(() {
//             messageTitle = message["notification"]["title"];
//             notificationAlert = "New Notification Alert";
//             print(messageTitle);
//           });
//         },
//         onResume: (message) async {
//           setState(() {
//             messageTitle = message["data"]["title"];
//             notificationAlert = "Application opened from Notification";
//             print(messageTitle);
//           });
//         },
//       );
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ProfessorsBloc(
                  initialState: ProfessorsState.initialState(),
                  messagesRepository: GetIt.instance<ProfessorsRepository>())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.grey),
          routes: {
            '/pharmacies': (context) =>
                // Body(),
                // HomeScreen()
                SplashScreen(),
            //  ProfessorsPage()
          },
          initialRoute: '/pharmacies',
        ));
  }
}

// class AppStarter extends StatefulWidget {
//   @override
//   _AppStarterState createState() => _AppStarterState();
// }

// class _AppStarterState extends State<AppStarter> {
//   FirebaseMessaging messaging = FirebaseMessaging as FirebaseMessaging;

//   Future<void> showMeMyToken() async {
//     var myToken = await messaging.getToken();
//     print("My Token is: " + myToken.toString());
//   }

//   @override
//   void initState() {
//     super.initState();

//     showMeMyToken();

//     FirebaseMessaging.instance.getInitialMessage().then((value) {
//       if (value != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return NotificationDetails();
//             },
//             settings: RouteSettings(
//               arguments: value.data,
//             ),
//           ),
//         );
//       }
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         print('Message on Foreground: ${message.notification}');
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) {
//               return NotificationDetails();
//             },
//             settings: RouteSettings(
//               arguments: message.data,
//             )),
//       );
//     });

//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Just a Test',
//       home: Body(),
//     );
//   }
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   print("Handling a background message :-): ${message.data}");
//   //Here you can do what you want with the message :-)
// }
