import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_city/main.dart';

const defaultAvatar =
    'https://caxhkekoeloyujcsovba.supabase.co/storage/v1/object/public/avatars/avatar.jpg';

class ProfileController extends GetxController {
  final RxnString nick = RxnString();
  final RxnString email = RxnString();
  final RxString avatar = RxString(defaultAvatar);
  final RxnString role = RxnString();
  final RxnString uid = RxnString();

  @override
  void onInit() async {
    super.onInit();
    final box = GetStorage();
    if (supabase.auth.currentUser?.id != null &&
        supabase.auth.currentUser?.id == box.read('uid')) {
      setProfileData(
          nick: box.read('nick'),
          email: box.read('email'),
          avatar: box.read('avatar'),
          role: box.read('role'),
          uid: box.read('uid'));
    } else {
      clearProfileData();
    }

    ever(nick, (String? value) {
      box.write('nick', value);
    });
    ever(email, (String? value) {
      box.write('email', value);
    });
    ever(avatar, (String? value) {
      box.write('avatar', value);
    });
    ever(role, (String? value) {
      box.write('role', value);
    });
    ever(uid, (String? value) {
      box.write('uid', value);
    });
  }

  void setProfileData(
      {String? nick,
      String? email,
      String avatar = defaultAvatar,
      String? role,
      String? uid}) async {
    this.nick.value = nick;
    this.email.value = email;
    this.avatar.value = avatar;
    this.role.value = role;
    this.uid.value = uid;
  }

  void clearProfileData() {
    nick.value = null;
    email.value = null;
    avatar.value = defaultAvatar;
    role.value = null;
    uid.value = null;
  }

  void updateAvatar(String avatarUrl) {
    avatar.value = avatarUrl;
  }
}
