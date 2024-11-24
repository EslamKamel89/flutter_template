import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/globals.dart';
import 'package:flutter_template/core/heleprs/snackbar.dart';
import 'package:flutter_template/core/router/app_router.dart';
import 'package:flutter_template/core/router/app_routes_names.dart';
import 'package:flutter_template/core/service_locator/service_locator.dart';
import 'package:flutter_template/core/static_data/app_strings.dart';
import 'package:flutter_template/core/themes/theme_cubit.dart';
import 'package:flutter_template/core/themes/toogle_theme_switch.dart';
import 'package:flutter_template/core/widgets/bottom_navigation_bar.dart';
import 'package:flutter_template/core/widgets/default_drawer.dart';
import 'package:flutter_template/core/widgets/default_screen_padding.dart';
import 'package:flutter_template/core/widgets/language_selector.dart';
import 'package:flutter_template/core/widgets/sizer.dart';
import 'package:intl/intl_standalone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await findSystemLocale();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/langs', // Path to translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(),
          )
        ],
        child: Builder(builder: (context) {
          final themeCubit = context.watch<ThemeCubit>();
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: themeCubit.state,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutesNames.splashScreen,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: serviceLocator<AppRouter>().onGenerateRoute,
          );
        }),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<Widget> _pages = [
    const Center(child: Text('Home Page', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Search Page', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Favorites Page', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 20))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tempelate'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      drawer: const DefaultDrawer(),
      bottomNavigationBar: defaultbottomNavigationBar(),
      body: DefaultScreenPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              const Sizer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Change Theme'),
                  Sizer(),
                  ToggleThemeSwitch(),
                ],
              ),
              const LanguageSelector(),
              const Sizer(),
              Text(AppStrings.WELCOME.tr()),
              const Sizer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('ElevatedButton'),
              ),
              const Sizer(),
              OutlinedButton(
                onPressed: () {},
                child: const Text('OutlinedButton'),
              ),
              const Sizer(),
              TextButton(
                onPressed: () {},
                child: const Text('TextButton'),
              ),
              const Sizer(),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Input Label',
                  hintText: 'Hint Text',
                  border: OutlineInputBorder(),
                ),
              ),
              const Sizer(),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  Sizer(),
                  Icon(Icons.star),
                  Sizer(),
                  Icon(Icons.settings),
                ],
              ),
              const Sizer(),
              ElevatedButton(
                onPressed: () {
                  showSnackbar('Success', 'This is the default success snack bar', false);
                },
                child: const Text('Success Snack Bar'),
              ),
              const Sizer(),
              ElevatedButton(
                onPressed: () {
                  showSnackbar('Error', 'This is the default error snack bar', true);
                },
                child: const Text('Error Snack Bar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
