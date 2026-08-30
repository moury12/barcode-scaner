import 'package:barcode_scaner/src/src_export.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash, // Usually splash is the initial route
    routes: [
           GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
 
    ],
  );
}
