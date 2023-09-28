import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/screens/policy.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final String route = '/profile';
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Профиль"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_rounded,
                )),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Obx(() => GestureDetector(
                        onTap: () async {
                          try {
                            final pickedFile = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedFile != null) {
                              final currentAvatarUrl =
                                  profileController.avatar.value;
                              final avatarKeyInBucket =
                                  'avatar-${supabase.auth.currentUser!.id}-${const Uuid().v4()}';
                              await supabase.storage.from('avatars').upload(
                                  avatarKeyInBucket, File(pickedFile.path));
                              final uploadedAvatarFileUrl = supabase.storage
                                  .from('avatars')
                                  .getPublicUrl(avatarKeyInBucket);
                              profileController
                                  .updateAvatar(uploadedAvatarFileUrl);
                              await supabase
                                  .from('profiles')
                                  .update({'avatar': uploadedAvatarFileUrl}).eq(
                                      'uid', supabase.auth.currentUser!.id);
                              print(currentAvatarUrl);
                              print(currentAvatarUrl.split('/').last);
                              await supabase.storage
                                  .from('avatars')
                                  .remove([currentAvatarUrl.split('/').last]);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 50,
                              backgroundImage: NetworkImage(
                                profileController.avatar.value,
                              ),
                            )),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      profileController.nick.value ?? '',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Мои комментарии',
                          style: TextStyle(color: Colors.orange.shade400),
                        )),
                    const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () {
                          context.push(const PolicyScreen().route);
                        },
                        child: Text(
                          'Политика конфиденциальности',
                          style: TextStyle(color: Colors.orange.shade400),
                        )),
                    const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Удалить аккаунт',
                          style: TextStyle(color: Colors.orange.shade400),
                        )),
                    const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () async {
                          await supabase
                              .from('profiles')
                              .update({'avatar': null}).eq(
                                  'uid', supabase.auth.currentUser!.id);
                          await supabase.storage.from('avatars').remove(
                              [profileController.avatar.value.split('/').last]);
                          profileController.avatar.value = defaultAvatar;
                        },
                        child: const Text('Удалить аватар')),
                    const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () async {
                          await supabase.auth.signOut();
                          if (!context.mounted) return;
                          profileController.clearProfileData();
                          context.go(ProfileSignInScreen().route);
                        },
                        child: Text(
                          'Выйти',
                          style: TextStyle(color: Colors.orange.shade400),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
