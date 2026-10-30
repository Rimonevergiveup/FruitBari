import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/localization/location_provider.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../../auth/controller/auth_controller.dart';
import 'widgets/edit_profile_dialog.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final location = ref.watch(locationProvider);
    final authState = ref.watch(authProvider);
    final user = authState.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'bn' ? 'আমার প্রোফাইল' : 'Account & Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_account_rounded),
            tooltip: 'Choose Portal',
            onPressed: () => context.push('/auth'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Avatar & Role Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEDE8DF)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primarySurface,
                        backgroundImage: user?.avatarUrl != null
                            ? NetworkImage(user!.avatarUrl!)
                            : null,
                        child: user?.avatarUrl == null
                            ? const Icon(Icons.person, size: 32, color: AppColors.primary)
                            : null,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? (lang == 'bn' ? 'অতিথি ফলপ্রেমী' : 'Guest Connoisseur'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user?.emailOrPhone ?? '+880 1711-223344',
                              style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: user?.isAdmin == true
                                    ? AppColors.error.withOpacity(0.12)
                                    : user?.isSeller == true
                                        ? AppColors.accentSubtle
                                        : AppColors.primarySurface,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                user?.isAdmin == true
                                    ? 'ADMINISTRATOR'
                                    : user?.isSeller == true
                                        ? 'FARMER / SELLER'
                                        : (lang == 'bn' ? 'ফল ক্রেতা (Customer)' : 'FRUIT CUSTOMER'),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: user?.isAdmin == true
                                      ? AppColors.error
                                      : user?.isSeller == true
                                          ? AppColors.accentWarm
                                          : AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (user != null && user.isCustomer)
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                          tooltip: 'Edit Profile',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => EditProfileDialog(currentUser: user),
                            );
                          },
                        ),
                    ],
                  ),
                  if (user != null && user.isCustomer) ...[
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.home_outlined, size: 16, color: AppColors.textMuted),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${user.deliveryAddress ?? 'Default Address'}, ${user.district ?? location.areaEn}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => EditProfileDialog(currentUser: user),
                            );
                          },
                          child: Text(
                            lang == 'bn' ? 'পরিবর্তন' : 'Edit',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Role Shortcut Buttons
            if (user?.isAdmin == true)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/admin'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.security_rounded, size: 18),
                  label: const Text('Open Administrator Console', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

            if (user?.isSeller == true)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/seller'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentWarm,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.agriculture_rounded, size: 18),
                  label: const Text('Open Farmer / Seller Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

            // Settings Tile Group
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEDE8DF)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.door_sliding_outlined, color: AppColors.primary),
                    title: Text(lang == 'bn' ? 'পোর্টাল পরিবর্তন ও লগইন' : 'Switch Role / Portals'),
                    subtitle: Text(lang == 'bn' ? 'ক্রেতা, চাষি বা অ্যাডমিন প্রবেশদ্বার' : 'Customer, Farmer or Admin entry'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () => context.push('/auth'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
                    title: Text(lang == 'bn' ? 'আমার অর্ডারসমূহ' : 'My Orders'),
                    subtitle: Text(lang == 'bn' ? 'পূর্ববর্তী অর্ডারের বিবরণ ও ট্র্যাকিং' : 'View order status & history'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () => context.push('/orders'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language_rounded, color: AppColors.primary),
                    title: Text(lang == 'bn' ? 'ভাষা পরিবর্তন (Language)' : 'Language (ভাষা)'),
                    subtitle: Text(lang == 'bn' ? 'বর্তমান: বাংলা' : 'Current: English'),
                    trailing: Switch(
                      value: lang == 'bn',
                      activeThumbColor: AppColors.primary,
                      onChanged: (val) {
                        ref.read(localeProvider.notifier).toggleLocale();
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.location_on_rounded, color: AppColors.primary),
                    title: Text(ref.tr('deliveryAddress')),
                    subtitle: Text(location.getDisplay(lang)),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () => context.push('/'),
                  ),
                  if (user != null) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.logout_rounded, color: AppColors.error),
                      title: Text(
                        lang == 'bn' ? 'লগআউট' : 'Sign Out',
                        style: const TextStyle(color: AppColors.error),
                      ),
                      onTap: () {
                        ref.read(authProvider.notifier).logout();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signed out successfully')),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // FruitBari Transparency & Zero-Carbide Guarantee Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5DDD0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const FruitBariLogo.symbol(width: 24, height: 24),
                      const SizedBox(width: 10),
                      Text(
                        lang == 'bn' ? 'ফ্রুটবাড়ি ১০০% বিশুদ্ধতার অঙ্গীকার' : 'FruitBari 100% Purity Pledge',
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lang == 'bn'
                        ? 'আমরা কোনো রাসায়নিক কার্বাইড বা ক্ষতিকর হরমোনযুক্ত ফল বিক্রি করি না। প্রতিটি ফল সরাসরি কৃষকের গাছপাকা অবস্থা থেকে সংগৃহীত।'
                        : 'Zero carbide, zero chemical boosters. Verified tree-ripened harvests directly from authentic generational orchards across Bangladesh.',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Support Hotline Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEDE8DF)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.support_agent_rounded, size: 28, color: AppColors.primary),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'bn' ? 'গ্রাহক সেবা ও বাগান হটলাইন' : 'Customer Support & Helpline',
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '+880 9612-FRUITS (09612-378487)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          lang == 'bn' ? 'সকাল ৯টা - রাত ১০টা' : '9:00 AM - 10:00 PM Daily',
                          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // FruitBari Brand Footer
            Center(
              child: Column(
                children: [
                  const FruitBariLogo.full(width: 140, showTagline: true),
                  const SizedBox(height: 8),
                  Text(
                    lang == 'bn'
                        ? 'সংস্করণ ১.০.০ • বাংলাদেশের সেরা মৌসুমি ফল প্ল্যাটফর্ম'
                        : 'Version 1.0.0 • Bangladesh Seasonal Fruit Marketplace',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
