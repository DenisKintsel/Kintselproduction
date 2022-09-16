import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/domain/entities/list_bool_model.dart';
import 'app/presentation/pages/splash_screen/view/splash_screen_view.dart';
import 'get_injector.dart' as sl;
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(listBoolModelAdapter());
  await sl.initGet();
  runApp(
    GetMaterialApp(
        supportedLocales: L10n.all,
        //locale: Provider.of<LocaleProvider>(context).locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: const SplashScreenView()),
  );
}
