import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const defaultAvatar =
    'https://caxhkekoeloyujcsovba.supabase.co/storage/v1/object/public/avatars/avatar.jpg';

class ProfileController extends GetxController {
  final RxnString nick = RxnString();
  final RxnString email = RxnString();
  final RxString avatar = RxString(defaultAvatar);
  final RxnString role = RxnString();
  final RxnString uid = RxnString();

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    final nickFromStorage = box.read('nick');
    final emailFromStorage = box.read('email');
    final avatarFromStorage = box.read('avatar');
    final roleFromStorage = box.read('role');
    final uidFromStorage = box.read('uid');

    if (nickFromStorage != null) {
      nick.value = nickFromStorage;
    }
    if (emailFromStorage != null) {
      email.value = emailFromStorage;
    }
    if (avatarFromStorage != null) {
      avatar.value = avatarFromStorage;
    }
    if (roleFromStorage != null) {
      role.value = roleFromStorage;
    }
    if (uidFromStorage != null) {
      uid.value = uidFromStorage;
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
