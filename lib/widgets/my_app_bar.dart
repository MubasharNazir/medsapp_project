import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medsapp_project/providers/active_theme_provider.dart';
import 'package:medsapp_project/widgets/theme_switch.dart';

//import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF50057),
      title: Text(
        'Flutter GPT',
        style: TextStyle(
          color: Colors.white,
          //  color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        Row(
          children: [
            Consumer(
              builder: (context, ref, child) => Icon(
                ref.watch(activeThemeProvider) == Themes.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
            const SizedBox(width: 8),
            const ThemeSwitch(),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
