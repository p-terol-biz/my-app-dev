import 'package:flutter/material.dart';
import 'package:myapp/screen/userLogin.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/ViewModel/deckListState.dart';

import '../ViewModel/firestoreDBInsertState.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final router = GoRouter(
    // パス (アプリが起動したとき)
    initialLocation: '/deckList',
    // パスと画面の組み合わせ
    routes: [
      GoRoute(
        path: '/userLogin',
        builder: (context, state) => const UserLogin(),
      ),
      GoRoute(
        path: '/deckList',
        builder: (context, state) => DeckListApp(),
      ),
      // GoRoute(
      //   path: '/deckDetail',
      //   builder: (context, state) => const DeckDetail(),
      // ),
      // GoRoute(
      //   path: '/firestoreInsertDB',
      //   builder: (context, state) => FirestoreInsertDB(),
      // ),
    ],
  );

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       home: Scaffold(
  //     appBar: AppBar(
  //       title: Text('Zutomayo Card'),
  //     ),
  //     backgroundColor: Colors.grey,
  //     body: DeckList(),
  //   ));
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
