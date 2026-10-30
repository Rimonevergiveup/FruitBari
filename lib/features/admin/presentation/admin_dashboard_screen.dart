import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../../auth/controller/auth_controller.dart';
import '../../orders/controller/orders_controller.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);
    final orders = ref.watch(ordersProvider);

    // Strict Access Check
    if (!authState.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Access Restricted')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FruitBariLogo.symbol(width: 56, height: 56),
                const SizedBox(height: 16),
                const Text(
                  'Administrative Access Restricted',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You must authenticate with authorized FruitBari platform credentials to access this dashboard.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.go('/auth/admin'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryDark),
                  child: const Text('Admin Login'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final sellers = authState.registeredSellers;
    final pendingSellers = sellers.where((s) => s.sellerStatus == SellerApprovalStatus.pending).toList();
    final approvedSellers = sellers.where((s) => s.sellerStatus == SellerApprovalStatus.approved).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FruitBariLogo.symbol(width: 28, height: 28),
            const SizedBox(width: 8),
            Text(lang == 'bn' ? 'অ্যাডমিন সেন্টার' : 'Platform Administration'),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/auth');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Identity Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.security_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              authState.currentUser?.name ?? 'Admin',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'ROOT ADMIN',
                                style: TextStyle(color: Colors.black, fontSize: 9.5, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          authState.currentUser?.emailOrPhone ?? '',
                          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Metrics Grid
            Row(
              children: [
                _metricCard(
                  label: lang == 'bn' ? 'অনুমোদিত বাগান' : 'Verified Orchards',
                  value: '${approvedSellers.length}',
                  icon: Icons.verified_user_rounded,
                  color: AppColors.freshGreen,
                ),
                const SizedBox(width: 10),
                _metricCard(
                  label: lang == 'bn' ? 'অপেক্ষমাণ আবেদন' : 'Pending Approvals',
                  value: '${pendingSellers.length}',
                  icon: Icons.pending_actions_rounded,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 10),
                _metricCard(
                  label: lang == 'bn' ? 'মোট অর্ডার' : 'Total Orders',
                  value: '${orders.length}',
                  icon: Icons.receipt_long_rounded,
                  color: AppColors.primary,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Pending Farmer Registrations Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lang == 'bn' ? 'বাগান যাচাই ও অনুমোদন কিউ' : 'Orchard Verification Queue',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: pendingSellers.isNotEmpty ? AppColors.accentSubtle : AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${pendingSellers.length} ${lang == 'bn' ? 'টি অপেক্ষমাণ' : 'Pending'}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: pendingSellers.isNotEmpty ? AppColors.accentWarm : AppColors.freshGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            if (pendingSellers.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEDE8DF)),
                ),
                child: Center(
                  child: Text(
                    lang == 'bn' ? 'বর্তমানে কোনো অপেক্ষমাণ আবেদন নেই।' : 'No pending seller applications currently.',
                    style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pendingSellers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final seller = pendingSellers[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFEDE8DF)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.storefront_rounded, color: AppColors.accentWarm, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                seller.shopName ?? 'Orchard',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accentSubtle,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Pending Review',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.accentWarm),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Owner: ${seller.name} • Contact: ${seller.emailOrPhone}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        Text(
                          'Location: ${seller.shopLocation ?? 'Bangladesh'}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                ref.read(authProvider.notifier).rejectSeller(seller.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Seller application rejected')),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.error,
                                side: const BorderSide(color: AppColors.error),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              child: const Text('Reject', style: TextStyle(fontSize: 12)),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                ref.read(authProvider.notifier).approveSeller(seller.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${seller.shopName} successfully verified and approved!'),
                                    backgroundColor: AppColors.freshGreen,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.freshGreen,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              ),
                              icon: const Icon(Icons.check, size: 16),
                              label: const Text('Approve Orchard', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

            const SizedBox(height: 24),

            // Approved Farmers List
            Text(
              lang == 'bn' ? 'অনুমোদিত ও সক্রিয় বাগানসমূহ' : 'Active Verified Orchards',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 10),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: approvedSellers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final seller = approvedSellers[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEDE8DF)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.freshGreen, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.shopName ?? seller.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                            ),
                            Text(
                              '${seller.name} • ${seller.shopLocation ?? 'Bangladesh'}',
                              style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Active Seller',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _metricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEDE8DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10.5, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
