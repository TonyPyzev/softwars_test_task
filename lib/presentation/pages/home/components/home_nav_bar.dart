import 'package:flutter/material.dart';

import 'nav_button.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 25,
      ),
      child: Row(
        children: [
          NavButton(
            title: 'Усі',
            isActive: true,
          ),
          NavButton(
            title: 'Робочі',
            isActive: false,
          ),
          NavButton(
            title: 'Особисті',
            isActive: false,
          ),
        ],
      ),
    );
  }
}
