import 'package:get/get.dart';

const defaultAvatar =
    'https://caxhkekoeloyujcsovba.supabase.co/storage/v1/object/public/avatars/avatar.jpg';

class ProfileController extends GetxController {
  final RxnString nick = RxnString();
  final RxnString email = RxnString();
  final RxnString avatar = RxnString();
  final RxnString role = RxnString();

  void setProfileData(
      {String? nick, String? email, String? avatar, String? role}) async {
    this.nick.value = nick;
    this.email.value = email;
    this.avatar.value = avatar;
    this.role.value = role;
  }

  void clearProfileData() {
    nick.value = null;
    email.value = null;
    avatar.value = null;
    role.value = null;
  }

  void updateAvatar(String avatarUrl) {
    avatar.value = avatarUrl;
  }
}
