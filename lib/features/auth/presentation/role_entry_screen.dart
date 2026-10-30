import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../controller/auth_controller.dart';

class RoleEntryScreen extends ConsumerWidget {
  const RoleEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'bn' ? 'প্রবেশদ্বার ও অ্যাকাউন্ট' : 'Choose Your Portal'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLocale();
            },
            icon: const Icon(Icons.language_rounded, size: 16),
            label: Text(lang == 'en' ? 'বাংলা' : 'EN'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // FruitBari Official Logo & Tagline
            const FruitBariLogo.full(
              width: 190,
              showTagline: true,
            ),
            const SizedBox(height: 14),
            Text(
              lang == 'bn' ? 'ফ্রুটবাড়ি পোর্টাল এক্সেস' : 'Welcome to FruitBari',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              lang == 'bn'
                  ? 'আপনার সঠিক ভূমিকা অনুযায়ী পোর্টালে প্রবেশ করুন'
                  : 'Select your role to access customized marketplace features',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

            if (authState.currentUser != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2DDD2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person_pin_rounded, size: 16, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      '${lang == 'bn' ? 'বর্তমান লগইন' : 'Signed in as'}: ${authState.currentUser!.name} (${authState.currentUser!.role.name.toUpperCase()})',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // 1. Customer Entry Card
            _portalCard(
              context: context,
              title: lang == 'bn' ? 'ফল ক্রেতা (Customer)' : 'Fruit Customer',
              subtitle: lang == 'bn'
                  ? 'তাজা ফল কিনুন, ঝুড়িতে যোগ করুন, ডেলিভারি ট্র্যাক করুন ও প্রোফাইল আপডেট করুন'
                  : 'Explore seasonal harvests, place orders, track fresh delivery & manage your profile',
              icon: Icons.shopping_basket_rounded,
              accentColor: AppColors.primary,
              badgeText: lang == 'bn' ? 'সাধারণ ব্যবহারকারী' : 'Public Access',
              primaryButtonText: lang == 'bn' ? 'ক্রেতা সাইন ইন / লগইন' : 'Customer Sign In',
              onPrimaryTap: () => context.push('/auth/customer'),
              secondaryButtonText: lang == 'bn' ? 'নতুন ক্রেতা অ্যাকাউন্ট' : 'Create Customer Account',
              onSecondaryTap: () => context.push('/auth/customer?register=true'),
            ),

            const SizedBox(height: 16),

            // 2. Farmer / Shop Owner Entry Card
            _portalCard(
              context: context,
              title: lang == 'bn' ? 'চাষি ও ফলের দোকান (Farmer / Seller)' : 'Farmer & Shop Owner',
              subtitle: lang == 'bn'
                  ? 'বাগান রেজিস্টার করুন, ফল লিস্টিং করুন ও প্রশাসনিক অনুমোদনের পর অর্ডার গ্রহণ করুন'
                  : 'Register your orchard, list freshly harvested fruits & manage orders after admin review',
              icon: Icons.agriculture_rounded,
              accentColor: AppColors.accentWarm,
              badgeText: lang == 'bn' ? 'যাচাইকৃত চাষি' : 'Verified Growers',
              primaryButtonText: lang == 'bn' ? 'চাষি / বিক্রেতা লগইন' : 'Farmer Sign In',
              onPrimaryTap: () => context.push('/auth/seller'),
              secondaryButtonText: lang == 'bn' ? 'বাগান বা শপ নিবন্ধন' : 'Register New Orchard',
              onSecondaryTap: () => context.push('/auth/seller-register'),
            ),

            const SizedBox(height: 16),

            // 3. Administrator Entry Card
            _portalCard(
              context: context,
              title: lang == 'bn' ? 'প্ল্যাটফর্ম প্রশাসক (Administrator)' : 'Platform Administrator',
              subtitle: lang == 'bn'
                  ? 'অনুমোদিত প্রশাসনিক হিসাবের মাধ্যমে চাষি যাচাই, লিস্টিং পর্যবেক্ষণ ও প্ল্যাটফর্ম পরিচালনা'
                  : 'Authorized control center to verify sellers, moderate fruit listings & inspect platform metrics',
              icon: Icons.admin_panel_settings_rounded,
              accentColor: AppColors.primaryDark,
              badgeText: lang == 'bn' ? 'শুধুমাত্র অনুমোদিত কর্তৃপক্ষ' : 'Authorized Access Only',
              badgeColor: AppColors.error.withOpacity(0.12),
              badgeTextColor: AppColors.error,
              primaryButtonText: lang == 'bn' ? 'সুরক্ষিত অ্যাডমিন লগইন' : 'Secure Admin Login',
              onPrimaryTap: () => context.push('/auth/admin'),
              isRestricted: true,
            ),

            const SizedBox(height: 24),

            // Quick Demo Role Switcher
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5DDD0)),
              ),
              child: Column(
                children: [
                  Text(
                    lang == 'bn' ? 'দ্রুত ডেমো ভূমিকা পরীক্ষা' : 'Quick Demo Portal Switcher',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      ActionChip(
                        avatar: const Icon(Icons.person, size: 14),
                        label: const Text('Customer', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          ref.read(authProvider.notifier).switchToDemoRole(UserRole.customer);
                          context.go('/');
                        },
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.agriculture, size: 14),
                        label: const Text('Farmer (Approved)', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          ref.read(authProvider.notifier).switchToDemoRole(UserRole.seller);
                          context.go('/seller');
                        },
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.security, size: 14),
                        label: const Text('Admin (Auth)', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          ref.read(authProvider.notifier).switchToDemoRole(UserRole.admin);
                          context.go('/admin');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Guest Browsing Link
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(
                lang == 'bn' ? 'লগইন ছাড়াই ফল দেখতে থাকুন →' : 'Continue Browsing Fruits as Guest →',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _portalCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required String badgeText,
    Color? badgeColor,
    Color? badgeTextColor,
    required String primaryButtonText,
    required VoidCallback onPrimaryTap,
    String? secondaryButtonText,
    VoidCallback? onSecondaryTap,
    bool isRestricted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDE8DF), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 26, color: accentColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: badgeColor ?? AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: badgeTextColor ?? AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onPrimaryTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    primaryButtonText,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if (secondaryButtonText != null && onSecondaryTap != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onSecondaryTap,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      secondaryButtonText,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
