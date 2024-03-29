
import 'package:flutter/cupertino.dart';

import 'l10n.dart';

class LocaleProvider with ChangeNotifier {
late Locale _locale;
  Locale get locale => _locale;
  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}