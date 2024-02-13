import 'package:flutter/material.dart';
import 'pages/myHomePage.dart';
import 'package:provider/provider.dart';

import 'providers/count_down_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: ((_) => CountdownProvider()))],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(
          title: "Tabata",
        ),
        // theme: AppTheme().currentTheme,
      ),
    );
  }
}