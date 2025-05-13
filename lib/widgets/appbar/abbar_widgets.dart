import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white, size: 35),
      title: Text(
        'CryptoCrest',
        style: Theme.of(
          context,
        ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
      ),
      centerTitle: true,
      backgroundColor: AppColors.appBarColor,
    );
  }

  Size get preferredSize => const Size.fromHeight(50);
}
