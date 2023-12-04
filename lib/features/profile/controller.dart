import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_city/main.dart';

const defaultAvatar =
    'https://caxhkekoeloyujcsovba.supabase.co/storage/v1/object/public/avatars/avatar.png';

class ProfileController extends GetxController {
  final RxnString nick = RxnString();
  final RxnString email = RxnString();
  final RxString avatar = RxString(defaultAvatar);
  final RxnString role = RxnString();
  final RxnString uid = RxnString();
  final RxnString id = RxnString();
  final comments = <dynamic>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final box = GetStorage();
    if (supabase.auth.currentUser != null) {
      try {
        setProfileData(
            nick: box.read('nick'),
            email: box.read('email'),
            avatar: box.read('avatar'),
            role: box.read('role'),
            uid: box.read('uid'),
            id: box.read('id'));
      } catch (e) {
        printError(info: 'Failed to retrieve profile data');
      }
    } else {
      clearProfileData();
    }

    ever(nick, (String? value) {
      box.write('nick', value);
    });
    ever(id, (String? value) {
      box.write('id', value);
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

  Future<void> fetchComments() async {
    List res = await supabase
        .from('news_comments')
        .select()
        .eq('created_by', id)
        .order('id', ascending: false);

    List likes = await supabase
        .from('news_comments_likes')
        .select()
        .in_('comment', res.map((e) => e['id']).toList());
    comments.value = res.map((e) {
      final like = likes.where((element) => element['comment'] == e['id']);
      return {
        ...e,
        'likes': like.length,
      };
    }).toList();
  }

  Future<void> getUpdatedNick() async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('uid', supabase.auth.currentUser!.id);
    final data = response[0];

    nick.value = data['nick'];
  }

  void setProfileData(
      {String? nick,
      String? email,
      String? id,
      String? avatar = '',
      String? role,
      String? uid}) async {
    this.nick.value = nick;
    this.email.value = email;
    this.avatar.value = avatar!.length > 1 ? avatar : defaultAvatar;
    this.role.value = role;
    this.uid.value = uid;
    this.id.value = id;
  }

  void clearProfileData() {
    nick.value = null;
    email.value = null;
    avatar.value = defaultAvatar;
    role.value = null;
    uid.value = null;
    id.value = null;
  }

  void updateAvatar(String avatarUrl) {
    if (avatarUrl.length > 1) {
      avatar.value = avatarUrl;
    }
  }
}
