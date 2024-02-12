import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/edit.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/screens/policy.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends HookWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final String route = '/profile';
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    profileController.fetchComments();

    return Scaffold(
        appBar: AppBar(
          title: Text(getAppLoc(context)!.profile),
          actions: [
            IconButton(
                onPressed: () {
                  context.push(const ProfileEdit().route);
                },
                icon: const Icon(
                  Icons.edit_rounded,
                )),
            IconButton(
                onPressed: () {
                  context.push(const SettingsScreen().route);
                },
                icon: const Icon(
                  Icons.settings,
                )),
            // IconButton(
            //     onPressed: () async {
            //       await context.push(const ProfileNotifications().route);
            //     },
            //     icon: const Icon(Icons.notifications_rounded))
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
                            }
                          } catch (e) {
                            // ignore: avoid_print
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
                        onPressed: () {
                          context.push(const PolicyScreen().route);
                        },
                        child: Text(
                          getAppLoc(context)!.policy,
                          style: TextStyle(color: Colors.orange.shade300),
                        )),
                    const SizedBox(height: 10),
                    // OutlinedButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Удалить аккаунт',
                    //       style: TextStyle(color: Colors.orange.shade300),
                    //     )),
                    // const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => DeleteConfirmAlert(
                                  text: getAppLoc(context)!.sureDeleteAvatar,
                                  onDelete: () async {
                                    await supabase
                                        .from('profiles')
                                        .update({'avatar': null}).eq('uid',
                                            supabase.auth.currentUser!.id);
                                    await supabase.storage
                                        .from('avatars')
                                        .remove([
                                      profileController.avatar.value
                                          .split('/')
                                          .last
                                    ]);
                                    profileController.avatar.value =
                                        defaultAvatar;
                                  }));
                        },
                        child: Text(
                          getAppLoc(context)!.deleteAvatar,
                        )),
                    const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () async {
                          await supabase.auth.signOut();
                          if (!context.mounted) return;
                          profileController.clearProfileData();
                          context.go(ProfileSignInScreen().route);
                        },
                        child: Text(
                          getAppLoc(context)!.exit,
                          style: TextStyle(color: Colors.orange.shade300),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
