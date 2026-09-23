import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/about_page.dart';
import '../../features/contact/contact_page.dart';
import '../../features/home/home_page.dart';
import '../../features/inspection/inspection_page.dart';
import '../../features/more/more_page.dart';
import '../../features/portfolio/portfolio_page.dart';
import '../../features/quotation/quotation_page.dart';
import '../../features/requests/request_details_page.dart';
import '../../features/requests/requests_page.dart';
import '../../features/service_request/request_success_page.dart';
import '../../features/service_request/service_request_page.dart';
import '../../features/services/service_details_page.dart';
import '../../features/services/services_page.dart';
import '../../features/settings/settings_page.dart';
import '../widgets/main_scaffold.dart';

class AppRoutes {
  AppRoutes._();
  static const home = '/';
  static const services = '/services';
  static const requests = '/requests';
  static const portfolio = '/portfolio';
  static const more = '/more';
  static const serviceDetails = '/service';
  static const serviceRequest = '/request';
  static const quotation = '/quotation';
  static const inspection = '/inspection';
  static const requestDetails = '/requests/details';
  static const requestSuccess = '/request/success';
  static const contact = '/contact';
  static const about = '/about';
  static const settings = '/settings';
}

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (_, state) => _fade(const HomePage(), state),
          ),
          GoRoute(
            path: AppRoutes.services,
            pageBuilder: (_, state) => _fade(const ServicesPage(), state),
          ),
          GoRoute(
            path: AppRoutes.requests,
            pageBuilder: (_, state) => _fade(const RequestsPage(), state),
          ),
          GoRoute(
            path: AppRoutes.portfolio,
            pageBuilder: (_, state) => _fade(const PortfolioPage(), state),
          ),
          GoRoute(
            path: AppRoutes.more,
            pageBuilder: (_, state) => _fade(const MorePage(), state),
          ),
        ],
      ),
      GoRoute(
        path: '${AppRoutes.serviceDetails}/:id',
        pageBuilder: (_, state) => _fade(
          ServiceDetailsPage(serviceId: state.pathParameters['id']!),
          state,
        ),
      ),
      GoRoute(
        path: AppRoutes.serviceRequest,
        pageBuilder: (_, state) => _fade(
          ServiceRequestPage(initialServiceId: state.uri.queryParameters['serviceId']),
          state,
        ),
      ),
      GoRoute(
        path: AppRoutes.quotation,
        pageBuilder: (_, state) => _fade(
          QuotationPage(initialServiceId: state.uri.queryParameters['serviceId']),
          state,
        ),
      ),
      GoRoute(
        path: AppRoutes.inspection,
        pageBuilder: (_, state) => _fade(
          InspectionPage(initialServiceId: state.uri.queryParameters['serviceId']),
          state,
        ),
      ),
      GoRoute(
        path: '${AppRoutes.requestDetails}/:id',
        pageBuilder: (_, state) => _fade(
          RequestDetailsPage(requestId: state.pathParameters['id']!),
          state,
        ),
      ),
      GoRoute(
        path: AppRoutes.requestSuccess,
        pageBuilder: (_, state) => _fade(
          RequestSuccessPage(requestId: state.uri.queryParameters['id'] ?? ''),
          state,
        ),
      ),
      GoRoute(
        path: AppRoutes.contact,
        pageBuilder: (_, state) => _fade(const ContactPage(), state),
      ),
      GoRoute(
        path: AppRoutes.about,
        pageBuilder: (_, state) => _fade(const AboutPage(), state),
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (_, state) => _fade(const SettingsPage(), state),
      ),
    ],
  );
}

CustomTransitionPage<void> _fade(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}