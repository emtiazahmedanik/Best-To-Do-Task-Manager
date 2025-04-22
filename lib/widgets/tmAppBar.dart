import 'dart:convert';

import 'package:besttodotask/screen/controller/authController.dart';
import 'package:besttodotask/screen/onboarding/loginScreen.dart';
import 'package:besttodotask/screen/profile/profileUpdateScreen.dart';
import 'package:flutter/material.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromProfile});

  final bool? fromProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromProfile ?? false) {
            return;
          }
          _onProfileTap(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  _shouldShowImage(AuthController.userModel?.photo)
                      ? MemoryImage(
                        base64Decode(AuthController.userModel?.photo ?? ''),
                      )
                      : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    AuthController.userModel?.fullName ?? 'Unknown',
                    style: textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    AuthController.userModel?.email ?? 'Unknown',
                    style: textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _onPressLogOutButton(context),
          icon: Icon(Icons.logout, color: Colors.white),
        ),
      ],
    );
  }

  bool _shouldShowImage(String? photo) {
    if (photo != null && photo.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _onProfileTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
    );
  }

  Future<void> _onPressLogOutButton(BuildContext context) async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
      (predicate) => false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
