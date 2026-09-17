import 'package:barcode_scaner/src/src_export.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash, // Usually splash is the initial route
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpPage(
            email: extra?['email'] as String?,
            isForgotPassword: extra?['isForgotPassword'] as bool? ?? false,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ResetPasswordPage(
            email: extra?['email'] as String?,
            token: extra?['token'] as String?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.mainLayout,
        builder: (context, state) => const MainLayout(),
      ),
      GoRoute(
        path: AppRoutes.activateShop,
        builder: (context, state) => const ActivateShopPage(),
      ),
      GoRoute(
        path: AppRoutes.choosePlan,
        builder: (context, state) => const ChoosePlanPage(),
      ),
      GoRoute(
        path: AppRoutes.subscriptionPayment,
        builder: (context, state) => const SubscriptionPaymentPage(),
      ),
      GoRoute(
        path: AppRoutes.subscriptionSuccess,
        builder: (context, state) => const SubscriptionSuccessPage(),
      ),
      GoRoute(
        path: AppRoutes.shopDetailsSetup,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final isEditing = extra?['isEditing'] as bool? ?? false;
          return ShopDetailsSetupPage(isEditing: isEditing);
        },
      ),
      GoRoute(
        path: AppRoutes.openingHours,
        builder: (context, state) => const OpeningHoursPage(),
      ),
      GoRoute(
        path: AppRoutes.findShop,
        builder: (context, state) => const FindShopPage(),
      ),
      GoRoute(
        path: AppRoutes.shopDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final shopId = extra?['shopId'] as String? ?? '';
          return ShopDetailsPage(shopId: shopId);
        },
      ),
      GoRoute(
        path: AppRoutes.scanShopQr,
        builder: (context, state) => const ScanShopQrPage(),
      ),
      GoRoute(
        path: AppRoutes.shopActivationPending,
        builder: (context, state) => const ShopActivationPendingPage(),
      ),
      GoRoute(
        path: AppRoutes.shopActivationSuccess,
        builder: (context, state) => const ShopActivationSuccessPage(),
      ),
      GoRoute(
        path: AppRoutes.redemptionSuccess,
        builder: (context, state) => const RedemptionSuccessPage(),
      ),
      GoRoute(
        path: AppRoutes.alreadyRedeemed,
        builder: (context, state) => const AlreadyRedeemedPage(),
      ),
      GoRoute(
        path: AppRoutes.notification,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: AppRoutes.personalInfo,
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.helpSupport,
        builder: (context, state) => const HelpSupportPage(),
      ),
      GoRoute(
        path: AppRoutes.faq,
        builder: (context, state) => const FaqPage(),
      ),
      GoRoute(
        path: AppRoutes.shopDashboard,
        builder: (context, state) => const ShopDashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.verifyRedemption,
        builder: (context, state) => const CustomerVerifiedPage(),
      ),
      GoRoute(
        path: AppRoutes.manualCodeEntry,
        builder: (context, state) => const ManualCodeEntryPage(),
      ),
      GoRoute(
        path: AppRoutes.customerRequest,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final customer = extra?['customer'] as CustomerMembershipModel?;
          return CustomerRequestPage(customer: customer);
        },
      ),
      GoRoute(
        path: AppRoutes.confirmActivation,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final customerName = extra?['customerName'] as String?;
          return ConfirmActivationPage(customerName: customerName);
        },
      ),
      GoRoute(
        path: AppRoutes.customerDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final customer = extra?['customer'] as CustomerMembershipModel?;
          return CustomerDetailsPage(customer: customer);
        },
      ),
      GoRoute(
        path: AppRoutes.redemptionHistory,
        builder: (context, state) => const RedemptionHistoryPage(),
      ),
    ],
  );
}
