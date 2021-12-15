import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/theme_controller.dart';

class CustomAppBar extends AppBar {
  final Widget tile;
  final BuildContext context;
  final ThemeController controller;
  final VoidCallback onLogout;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar({
    Key? key,
    required this.controller,
    required this.context,
    required this.tile,
    required this.onLogout,
  }) : super(
          key: key,
          centerTitle: true,
          title: tile,
          actions: [
            IconButton(
              icon: Obx(
                () => Icon(
                  controller.darkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
              onPressed: () => controller.darkMode = !controller.darkMode,
            ),
            IconButton(
              key: const ValueKey("logoutAction"),
              icon: const Icon(Icons.exit_to_app),
              onPressed: onLogout,
            ),
          ],
        );
}
