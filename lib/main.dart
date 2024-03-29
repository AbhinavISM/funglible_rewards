import 'package:firebase_core/firebase_core.dart';
import 'package:flipgrid/firebase_options.dart';
import 'package:flipgrid/login_signup/new_login.dart';
import 'package:flipgrid/models/user.dart';
import 'package:flipgrid/successful_payment_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (!kIsWeb) {
  //   Stripe.publishableKey = publishableKey;
  // }
  runApp(const ProviderScope(child: MyApp()));
}

final currentUserStateProvider =
    ChangeNotifierProvider((ref) => CurrentUserState());
final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class CurrentUserState extends ChangeNotifier {
  // late Customer _user;
  Customer _user = Customer(
    name: "testUser",
    email: "testemail@gmail.com",
    password: "testpass",
    customerAddress: "testCustomerAddress",
    lastLogin: DateTime.now().toString(),
    tokens: 3,
    loginStreak: 5,
    fbFollowed: false,
    instaFollowed: false,
    twitterFollowed: false,
  );
  set setCurrentUser(Customer user) {
    _user = user;
    notifyListeners();
  }

  Customer get getCurrentUser {
    return _user;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewLogin(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        // etc.
      };
}
