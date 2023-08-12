import 'package:firebase_core/firebase_core.dart';
import 'package:flipgrid/firebase_options.dart';
import 'package:flipgrid/login_signup/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final userProvider = Provider((ref) => const User(
    name: "Test User",
    password: "Test Password",
    address: "Test Adress",
    loyalityPoints: 0));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      // home: ProductCard(
      //   product: Product(
      //     name: 'Example Product',
      //     company: 'Example Company',
      //     price: '99.99',
      //     description: 'This is an example product description.',
      //     rating: 4.5,
      //     image:
      //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT07rBgmmDf044uLXn2m7qaqA3iJoRw7g5xoem8860JNw&s',
      //   ),
      // ),
      // home: DetailsScreen(
      //   product: demoCarts[0].product,
      // ),
      // home: const FollowToEarn(title: 'Flutter Demo Home Page'),
    );
  }
}
