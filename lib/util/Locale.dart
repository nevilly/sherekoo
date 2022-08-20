

import 'Locale/English.dart';
import 'Locale/Swahili.dart';

class OLocale {
  OLocale(
    this.swahili,
    this.key,
  ) : super();
  final bool swahili;
  final int key;
  String get() {
    return swahili ? Swahili(key).words() : English(key).words();
  }
}
