import 'package:e_commerce/app/pages/auth/sign_in_page.dart';
import 'package:e_commerce/app/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/auth_widget.dart';
import 'app/pages/admin/admin_home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
          signedInBuilder: (context) => Scaffold(
                  body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Signed In'),
                    ElevatedButton(
                        onPressed: () {
                          ref.read(firebaseAuthProvider).signOut();
                        },
                        child: const Text('Sign Out'))
                  ],
                ),
              )),
          nonSignedInBuilder: (context) => const SignInPage()),
    );
  }
}


// class MyApp extends ConsumerWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final count = ref.watch(counterProvider);
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Scaffold(
//           body: Center(
//             child: Text(count.toString()),
//           ),
//           floatingActionButton: Row(
//             children: [
//               FloatingActionButton(
//                 onPressed: () {
//                   ref.read(counterProvider.notifier).increment();
//                 },
//                 child: const Icon(Icons.add),
//               ),
//               FloatingActionButton(
//                 onPressed: () {
//                   ref.read(counterProvider.notifier).decerement();
//                 },
//                 child: const Icon(Icons.remove),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// final counterProvider = StateNotifierProvider((ref) {
//   return Counter();
// });

// class Counter extends StateNotifier<int> {
//   Counter() : super(0);

//   void increment() => state++;
//   void decerement() => state--;
// }
