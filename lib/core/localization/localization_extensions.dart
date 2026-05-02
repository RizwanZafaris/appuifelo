import 'package:flutter/widgets.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';

extension FeloLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
