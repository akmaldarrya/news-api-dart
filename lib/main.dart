
import 'package:flutter/material.dart';
import 'package:news_api_application/posts.dart';
// import 'login.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'HTTP',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
  primarySwatch: Colors.indigo,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  home: PostsPage(),

 );
 }
}