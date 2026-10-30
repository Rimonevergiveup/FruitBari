import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../controller/auth_controller.dart';

class SellerLoginScreen extends ConsumerStatefulWidget {
  const SellerLoginScreen({super.key});

  @override
  ConsumerState<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends ConsumerState<SellerLoginScreen> {
  final _contactController = TextEditingController(text: 'fazlur@fruitbari.com');
  final _passwordController = TextEditingController(text: 'seller123');

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final success = await ref.read(authProvider.notifier).loginSeller(
          emailOrPhone: _contactController.text,
          password: _passwordController.text,
        );

    if (success && mounted) {
      context.go('/seller');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'bn' ? 'চাষি ও দোকানদার লগইন' : 'Farmer / Seller Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: FruitBariLogo.compact(height: 38),
            ),
            const SizedBox(height: 18),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentWarm.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.agriculture_rounded,
                  size: 48,
                  color: AppColors.accentWarm,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                lang == 'bn' ? 'কৃষক ও বিক্রেতা পোর্টাল' : 'Farmer & Orchard Portal',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                lang == 'bn'
                    ? 'আপনার অনুমোদিত বাগান বা ফল দোকানের হিসাব দিয়ে লগইন করুন।'
                    : 'Manage your seasonal fruit inventory, orders & verified harvest listings.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              lang == 'bn' ? 'নিবন্ধিত ফোন বা ইমেইল' : 'Registered Phone or Email',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.accentWarm),
                hintText: 'fazlur@fruitbari.com or 01XXXXXXXXX',
              ),
            ),

            const SizedBox(height: 16),

            Text(
              lang == 'bn' ? 'পাসওয়ার্ড' : 'Password',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.accentWarm),
                hintText: '••••••••',
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: authState.isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentWarm,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: authState.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : Text(
                      lang == 'bn' ? 'লগইন করুন' : 'Sign In as Seller',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
            ),

            const SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () => context.push('/auth/seller-register'),
                child: Text(
                  lang == 'bn'
                      ? 'নতুন কৃষক? নতুন বাগান বা দোকান নিবন্ধন করুন →'
                      : 'New Orchardist? Register Your Orchard →',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
