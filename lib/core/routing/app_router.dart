import 'package:go_router/go_router.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/auth/presentation/admin_login_screen.dart';
import '../../features/auth/presentation/customer_login_screen.dart';
import '../../features/auth/presentation/role_entry_screen.dart';
import '../../features/auth/presentation/seller_login_screen.dart';
import '../../features/auth/presentation/seller_register_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/orders/presentation/order_success_screen.dart';
import '../../features/orders/presentation/orders_history_screen.dart';
import '../../features/product_details/presentation/product_details_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/seasonal_calendar/presentation/seasonal_calendar_screen.dart';
import '../../features/seller/presentation/seller_dashboard_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/home',
      redirect: (context, state) => '/',
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const SeasonalCalendarScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ProductDetailsScreen(fruitId: id);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/order-success/:orderId',
      builder: (context, state) {
        final orderId = state.pathParameters['orderId'] ?? '';
        return OrderSuccessScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersHistoryScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    // Auth & Role Entry Routes
    GoRoute(
      path: '/auth',
      builder: (context, state) => const RoleEntryScreen(),
    ),
    GoRoute(
      path: '/auth/customer',
      builder: (context, state) {
        final isRegister = state.uri.queryParameters['register'] == 'true';
        return CustomerLoginScreen(initialIsRegister: isRegister);
      },
    ),
    GoRoute(
      path: '/auth/seller',
      builder: (context, state) => const SellerLoginScreen(),
    ),
    GoRoute(
      path: '/auth/seller-register',
      builder: (context, state) => const SellerRegisterScreen(),
    ),
    GoRoute(
      path: '/auth/admin',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    // Role-specific Dashboards
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/seller',
      builder: (context, state) => const SellerDashboardScreen(),
    ),
  ],
);
