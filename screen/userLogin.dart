import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String _email = '';
  String _password = '';

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  push(BuildContext context) {
    // 画面 B へ進む
    context.push('/deckDetail');
  }

  @override
  Widget build(BuildContext context) {
    final appBar =
        AppBar(backgroundColor: Colors.purple, title: const Text('User Login'));

    return Scaffold(
        appBar: appBar,
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'ユーザー名'),
                      onChanged: (String value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'パスワード'),
                      obscureText: true,
                      onChanged: (String value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: const Text('ユーザ登録'),
                      onPressed: () async {
                        try {
                          final User? user = (await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _email, password: _password))
                              .user;
                          if (user != null)
                            print("ユーザ登録しました ${user.email} , ${user.uid}");
                        } catch (e) {
                          print('Error:  $e');
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // 4行目 ログインボタン
                    ElevatedButton(
                      child: const Text('ログイン'),
                      onPressed: () async {
                        try {
                          // メール/パスワードでログイン
                          final User? user = (await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password))
                              .user;
                          if (user != null) {
                            print("ログインしました ${user.email} , ${user.uid}");
                            // push(context);
                          }
                        } catch (e) {
                          print('Error:  $e');
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // 5行目 パスワードリセット登録ボタン
                    ElevatedButton(
                        child: const Text('パスワードリセット'),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _email);
                            print("パスワードリセット用のメールを送信しました");
                          } catch (e) {
                            print('Error:  $e');
                          }
                        }),
                  ],
                ))));
  }
}
