import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:copick_data_web/routes/route_generator.dart';
import 'package:copick_data_web/routes/routes.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBH7OPHLLl0rRhkVznXFOu15YV-mgWbk7s",
        authDomain: "ctg-app-80208.firebaseapp.com",
        projectId: "ctg-app-80208",
        storageBucket: "ctg-app-80208.appspot.com",
        messagingSenderId: "529322696116",
        appId: "1:529322696116:web:ae76584e7a20aa8feaa6e1",
        measurementId: "G-41XK5HCY5Q"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GetDataProvider>(
          create: (_) => GetDataProvider(),
        ),
        ChangeNotifierProvider<EnterVolumesProvider>(
          create: (_) => EnterVolumesProvider(),
        ),
      ],
      child: EasyLocalization(
        path: 'assets/language',
        supportedLocales: [
          Locale('ko', 'KR'),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: '수거량 입력 페이지',
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: KColors.backgroundGrey,
        primaryColor: KColors.lightPrimary,
        fontFamily: 'NotoSansKR',
        iconTheme: const IconThemeData(color: KColors.black),
        appBarTheme: const AppBarTheme(
          backgroundColor: KColors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: kAppbarTitle,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: KColors.black,
          ),
        ),
        textTheme: TextTheme(),
        cardTheme: CardTheme(
          color: KColors.white,
          elevation: 4,
          margin: const EdgeInsets.fromLTRB(NORMALGAP, 0, NORMALGAP, NORMALGAP),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SMALLGAP),
          ),
        ),
      ),
    );
  }
}

