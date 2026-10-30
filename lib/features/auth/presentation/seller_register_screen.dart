import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../controller/auth_controller.dart';

class SellerRegisterScreen extends ConsumerStatefulWidget {
  const SellerRegisterScreen({super.key});

  @override
  ConsumerState<SellerRegisterScreen> createState() => _SellerRegisterScreenState();
}

class _SellerRegisterScreenState extends ConsumerState<SellerRegisterScreen> {
  final _nameController = TextEditingController(text: 'Anwar Hossain');
  final _shopNameController = TextEditingController(text: 'Mithapukur Haribhanga Agro');
  final _contactController = TextEditingController(text: '01722-334455');
  final _locationController = TextEditingController(text: 'Mithapukur, Rangpur');
  final _passwordController = TextEditingController(text: 'secret123');

  @override
  void dispose() {
    _nameController.dispose();
    _shopNameController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final success = await ref.read(authProvider.notifier).registerSeller(
          name: _nameController.text,
          shopName: _shopNameController.text,
          emailOrPhone: _contactController.text,
          shopLocation: _locationController.text,
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
        title: Text(lang == 'bn' ? 'বাগান ও বিক্রেতা নিবন্ধন' : 'Register Orchard / Shop'),
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

            // Header Info Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primaryLight.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.verified_user_rounded, color: AppColors.primary, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'bn' ? 'অনুমোদন ও যাচাইকরণ ধাপ' : 'Verification Step Notice',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          lang == 'bn'
                              ? 'শতভাগ কার্বাইডমুক্ত ও খাঁটি ফলের গুণমান নিশ্চিত করতে নতুন বিক্রেতাদের তথ্য ফ্রুটবাড়ি প্রশাসক যাচাই করবেন। অনুমোদনের পর ফল বিক্রয় শুরু করা যাবে।'
                              : 'To protect customer trust and ensure authentic carbide-free sourcing, registrations undergo a short review by FruitBari Admin before listing fruits.',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              lang == 'bn' ? 'চাষি বা স্বত্বাধিকারীর নাম' : 'Owner / Farmer Full Name',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline, color: AppColors.accentWarm),
                hintText: 'e.g. Anwar Hossain',
              ),
            ),

            const SizedBox(height: 16),

            Text(
              lang == 'bn' ? 'বাগান বা দোকানের নাম' : 'Shop or Orchard Name',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _shopNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.storefront_rounded, color: AppColors.accentWarm),
                hintText: 'e.g. Mithapukur Haribhanga Agro',
              ),
            ),

            const SizedBox(height: 16),

            Text(
              lang == 'bn' ? 'মোবাইল নম্বর অথবা ইমেইল' : 'Contact Phone (+880) or Email',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_iphone_rounded, color: AppColors.accentWarm),
                hintText: '01XXXXXXXXX',
              ),
            ),

            const SizedBox(height: 16),

            Text(
              lang == 'bn' ? 'বাগানের অবস্থান (উপজেলা ও জেলা)' : 'Orchard Location (Upazila & District)',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.accentWarm),
                hintText: 'e.g. Mithapukur, Rangpur or Shibganj, Chapai',
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

            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: authState.isLoading ? null : _register,
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
                      lang == 'bn' ? 'নিবন্ধন জমা দিন ও যাচাইয়ে পাঠান' : 'Submit Registration for Review',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
