import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:smart_hafazan/dashboard.dart';
import 'package:smart_hafazan/screens/sign/signup_page.dart';
import 'package:smart_hafazan/surah_list_page.dart';
import 'package:smart_hafazan/tajwid_page.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_hafazan/firebase_options.dart';

import 'package:smart_hafazan/app_routes.dart';
import 'package:smart_hafazan/cubits/bookmarks/cubit.dart';
import 'package:smart_hafazan/cubits/chapter/cubit.dart';
import 'package:smart_hafazan/cubits/juz/cubit.dart';
import 'package:smart_hafazan/models/ayah/ayah.dart';
import 'package:smart_hafazan/models/chapter/chapter.dart';
import 'package:smart_hafazan/models/juz/juz.dart';
import 'package:smart_hafazan/providers/app_provider.dart';
import 'package:smart_hafazan/providers/onboarding_provider.dart';
import 'package:smart_hafazan/screens/bookmarks/bookmarks_screen.dart';
import 'package:smart_hafazan/screens/home/home_screen.dart';
import 'package:smart_hafazan/screens/juz/juz_index_screen.dart';
import 'package:smart_hafazan/screens/onboarding/onboarding.dart';
import 'package:smart_hafazan/screens/splash/splash.dart';
import 'package:smart_hafazan/screens/surah/surah_index_screen.dart';

import 'configs/core_theme.dart' as theme;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

// hive
  await Hive.initFlutter();

  Hive.registerAdapter<Juz>(JuzAdapter());
  Hive.registerAdapter<Ayah>(AyahAdapter());
  Hive.registerAdapter<Chapter>(ChapterAdapter());

  await Hive.openBox('app');
  await Hive.openBox('data');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          return MaterialChild(
            value: value,
          );
        }),
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider? value;
  const MaterialChild({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hafazan',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      themeMode: value!.themeMode,
      home: Builder(
        builder: (context) => HomeScreen(
          maxSlide: MediaQuery.of(context).size.width * 0.835,
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: <String, WidgetBuilder>{
        AppRoutes.juz: (context) => const JuzIndexScreen(),
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.surah: (context) => const SurahIndexScreen(),
        AppRoutes.bookmarks: (context) => const BookmarksScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.dashboard: (context) => const Dashboard(),
        AppRoutes.sign: (context) => SignUpScreen(),
        AppRoutes.nota: (context) => const TajwidPage(),
        AppRoutes.hafalsurahs: (context) => SurahListPage(),
        AppRoutes.home: (context) =>
            HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),
      },
    );
  }
}


