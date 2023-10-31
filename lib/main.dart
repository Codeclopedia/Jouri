import 'package:Jouri/ui/checkout/checkout_view_model.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:Jouri/ui/splash_screen/splash_screen.dart';
import 'package:Jouri/ui/splash_screen/splash_screen_view_model.dart';
import 'package:Jouri/utilities/general.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    var supportedLocales = <Locale>[const Locale('ar'), const Locale('en')];
    var lang = await General.getStringSP('lang');

    runApp(
      KLocalizations.asChangeNotifier(
        locale: Locale(lang ?? 'en'),
        defaultLocale: Locale(lang ?? 'en'),
        supportedLocales: supportedLocales,
        localizationsAssetsPath: 'lang',
        child: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => NavMenuViewModel()),
          ChangeNotifierProvider(create: (context) => CheckoutViewModel())
        ], child: MyApp()),
      ),
    );
  } catch (e) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    var supportedLocales = <Locale>[const Locale('ar'), const Locale('en')];
    // var lang = await General.getStringSP('lang');

    runApp(
      KLocalizations.asChangeNotifier(
        locale: Locale('en'),
        defaultLocale: Locale('en'),
        supportedLocales: supportedLocales,
        localizationsAssetsPath: 'lang',
        child: ChangeNotifierProvider(
            create: (context) => NavMenuViewModel(), child: MyApp()),
      ),
    );
    // runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<KLocalizations>(context);
    var currentLang = General.getLanguage(context);

    try {
      return MaterialApp(
          title: 'Flutter Demo',
          locale: localizations.locale,
          supportedLocales: localizations.supportedLocales,
          builder: EasyLoading.init(),
          localizationsDelegates: [
            localizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xff231F20),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0xffEC297B),
            ),

            /// ElevatedButton
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: const Color(0xffEC297B),
                fixedSize: const Size(170, 31),
                textStyle: currentLang == 'ar'
                    ? GoogleFonts.almarai(
                        textStyle: const TextStyle(
                        color: Color(0xfff8f9ff),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3.2,
                      ))
                    : GoogleFonts.raleway(
                        textStyle: const TextStyle(
                        color: Color(0xfff8f9ff),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3.2,
                      )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),

            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
              textStyle: currentLang == 'ar'
                  ? GoogleFonts.almarai(
                      textStyle: const TextStyle(
                      color: Color(0xffEC297B),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3.2,
                    ))
                  : GoogleFonts.raleway(
                      textStyle: const TextStyle(
                      color: Color(0xffEC297B),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3.2,
                    )),
            )),

            /// InputFields
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey.shade50,
                hintStyle: const TextStyle(color: Colors.black45),
                labelStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Color(0xff97969a),
                  fontSize: 14,
                )),

            /// AppBar
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffFFFFFF),
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xff231F20)),
            ),

            /// TextTheme
            textTheme: currentLang == 'ar'
                ? GoogleFonts.almaraiTextTheme()
                : GoogleFonts.ralewayTextTheme(),
            // fontFamily: 'Raleway',
          ),
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => SplashScreenViewModel(context)),
            ],
            child: SplashScreen(),
          ));
    } catch (e) {
      return Container();
    }
  }
}
