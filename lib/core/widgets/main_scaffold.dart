import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../localization/generated/app_localizations.dart';
import '../routing/app_router.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  static const _paths = [
    AppRoutes.home,
    AppRoutes.services,
    AppRoutes.requests,
    AppRoutes.portfolio,
    AppRoutes.more,
  ];

  int _indexOf(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    for (var i = _paths.length - 1; i >= 0; i--) {
      if (loc == _paths[i] || loc.startsWith('${_paths[i]}/')) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final idx = _indexOf(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: NavigationBar(
          selectedIndex: idx,
          height: 68,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (i) {
            if (i == idx) return;
            context.go(_paths[i]);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.grid_view_outlined),
              selectedIcon: const Icon(Icons.grid_view),
              label: l.navServices,
            ),
            NavigationDestination(
              icon: const Icon(Icons.receipt_long_outlined),
              selectedIcon: const Icon(Icons.receipt_long),
              label: l.navRequests,
            ),
            NavigationDestination(
              icon: const Icon(Icons.work_outline),
              selectedIcon: const Icon(Icons.work),
              label: l.navPortfolio,
            ),
            NavigationDestination(
              icon: const Icon(Icons.menu_outlined),
              selectedIcon: const Icon(Icons.menu),
              label: l.navMore,
            ),
          ],
        ),
      ),
    );
  }
}