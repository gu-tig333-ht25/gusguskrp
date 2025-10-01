import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'home_page.dart';
import 'TextFieldView.dart';
import 'Network.dart';

void main() {
  NetworkConnectionState newtorkState = NetworkConnectionState();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => newtorkState)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NetworkConnectionState conection = context.watch<NetworkConnectionState>();
    Network? n = conection.connection;
    ThemeData appTheme = ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.grey,
          colorScheme: const ColorScheme.light(
            primary: Colors.grey,
            onPrimary: Colors.white70,
            secondary: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.black,
            centerTitle: true,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            iconSize: 50,
            shape: CircleBorder(),
          ),
        );
    if (n == null) {
      // No network yet, show connect screen
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'TODO APP',
        home: ConnectNetwork("https://todoapp-api.apps.k8s.gu.se"),
      );
    }

    // Network exists, provide TodoItemsState to the WHOLE app
    return ChangeNotifierProvider(
      create: (_) => TodoItemsState(connection: n),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO APP',
        theme: appTheme,
        home: MyHomePage(title: 'TIG333 TODO'),
      ),
    );
  }
}
