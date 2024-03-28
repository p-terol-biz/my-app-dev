import 'package:flutter/material.dart';
import 'package:zutomayoddeck/screen/userLogin.dart';
import 'package:go_router/go_router.dart';
import 'package:zutomayoddeck/ViewModel/deckListState.dart';

import '../ViewModel/firestoreDBInsertState.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final router = GoRouter(
    // パス (アプリが起動したとき)
    initialLocation: '/deckList',
    // errorPageBuilder: (context, state) => MaterialPage(child: ErrorPage()),
    // パスと画面の組み合わせ
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/userLogin',
        builder: (context, state) => const UserLogin(),
      ),
      GoRoute(
        path: '/deckList',
        builder: (context, state) => const DeckListApp(),
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

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple, // 背景色を紫色に設定
      child: Center(
        child:
            Image.asset('assets/zutomayocard_logo.png'), // カスタムスプラッシュ画面の画像を表示
      ),
    );
  }
}
