import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:smart_city/controller.dart';
import 'package:flutter/material.dart';

AppLocalizations? getAppLoc(BuildContext context) {
  return AppLocalizations.of(context);
}

final loc = Get.find<GlobalController>().locale;
