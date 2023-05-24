import 'package:flutter/material.dart';

import 'nav_button.dart';

class HomeNavBar extends StatefulWidget {
  final PageController pageController;

  const HomeNavBar({
    super.key,
    required this.pageController,
  });

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  late int curentPage;

  @override
  void initState() {
    curentPage = widget.pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToPage(0);
              },
              child: NavButton(
                title: 'Усі',
                isActive: curentPage == 0 ? true : false,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToPage(1);
              },
              child: NavButton(
                title: 'Робочі',
                isActive: curentPage == 1 ? true : false,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToPage(2);
              },
              child: NavButton(
                title: 'Особисті',
                isActive: curentPage == 2 ? true : false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int page) {
    if (curentPage != page) {
      widget.pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
      setState(() {
        curentPage = page;
      });
    }
  }
}
