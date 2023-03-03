import 'package:e_commerce/app/pages/auth/sign_in_page.dart';
import 'package:e_commerce/app/pages/user/user_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app/auth_widget.dart';
import 'app/pages/admin/admin_home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "pk_test_51LdRJCSFHtKcizMkgI8hO9HUEooZQaqPaqIHVEJjUgxAUmda5XWa4Obu3JqsfZax7iPuGqoxk4dW0MCy7M4OJmlT00AbPQG84e";
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.orange,
          seedColor: Colors.orange,
        ),
      ),
      home: AuthWidget(
          adminSignedInBuilder: (context) => const AdminHome(),
          signedInBuilder: (context) => const UserHome(),
          nonSignedInBuilder: (context) => const SignInPage()),
    );
  }
}
