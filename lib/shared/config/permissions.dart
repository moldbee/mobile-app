import 'package:get/get.dart';
import 'package:smart_city/features/profile/controller.dart';

class Permissions {
  static ProfileController profileController = Get.find<ProfileController>();
  String? role = profileController.role.value;

  getForNewsAndEvents() {
    return false;
  }

  getForComments() {
    return false;
  }

  getForServiceCategories() {
    return false;
  }

  getForServices() {
    return false;
  }

  getForCompany(int? profileId) {
    // return role == 'admin' ||
    //     profileController.id.value == profileId.toString();
    return false;
  }
}
