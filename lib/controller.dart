import 'dart:ui';

import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Locale> locale = const Locale('ro').obs;
}
