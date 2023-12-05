import 'package:get/get.dart';
import 'package:smart_city/features/profile/controller.dart';

class Permissions {
  static ProfileController profileController = Get.find<ProfileController>();
  String? role = profileController.role.value;

  getForNewsAndEvents() {
    return role == 'admin' || role == 'editor';
  }

  getForComments() {
    return role == 'admin' || role == 'editor' || role == 'moderator';
  }

  getForServiceCategories() {
    return role == 'admin';
  }

  getForServices() {
    return role == 'dadawdawdawawdaw';
  }

  getForCompany(int? profileId) {
    return role == 'admin' ||
        profileController.id.value == profileId.toString();
  }
}
