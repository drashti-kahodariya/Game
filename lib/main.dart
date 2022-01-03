import 'package:flutter/material.dart';
import 'package:game/Screen/first_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:get_storage/get_storage.dart';
import 'Providers/game_list_providers.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) =>
      Sizer(builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => GameListProviders()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Game List Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: FirstScreen(),
          ),
        );
      });
}
