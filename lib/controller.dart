import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Locale> locale = const Locale('ro').obs;

  @override
  void onInit() {
    super.onInit();
    final storage = GetStorage();
    ever(locale, (_) {
      storage.write('locale', locale.value.languageCode);
    });
    final localeFromStorage = storage.read('locale');

    if (localeFromStorage != null) {
      locale.value = Locale(localeFromStorage);
    }
  }
}
