import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../controller/auth_controller.dart';

class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _emailController = TextEditingController(text: kAuthorizedAdminEmail);
  final _passwordController = TextEditingController(text: kAuthorizedAdminPassword);
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAdminLogin() async {
    final success = await ref.read(authProvider.notifier).loginAdmin(
          email: _emailController.text,
          password: _passwordController.text,
        );

    if (success && mounted) {
      context.go('/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'bn' ? 'প্রশাসনিক লগইন' : 'Administrator Portal'),
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

            // Admin Shield Header
            Center(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.security_rounded,
                  size: 48,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                lang == 'bn' ? 'সুরক্ষিত প্রশাসনিক প্রবেশাধিকার' : 'Secure Admin Access',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                lang == 'bn'
                    ? 'প্রশাসক অ্যাকাউন্ট শুধু পূর্বানুমোদিত ক্রেডেনশিয়াল দ্বারা যাচাইযোগ্য।'
                    : 'Restricted to authorized system operators. Role tampering is strictly prevented.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
              ),
            ),

            const SizedBox(height: 24),

            // Strict Role Security Warning Notice
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.accentSubtle,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.accent.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lock_person_rounded, size: 20, color: AppColors.accentWarm),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      lang == 'bn'
                          ? 'সতর্কতা: ভূমিকা পরিবর্তন করে কেউ প্রশাসক হতে পারবে না। শুধুমাত্র বৈধ অনুমোদিত অ্যাকাউন্টের মাধ্যমে অ্যাক্সেস পাওয়া সম্ভব।'
                          : 'Security Notice: Users cannot become administrators by simply selecting a role. Direct credential verification against authorized administrative accounts is strictly enforced.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Authorized Admin Email Field
            Text(
              lang == 'bn' ? 'অনুমোদিত প্রশাসক ইমেইল' : 'Authorized Administrator Email',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryDark),
                hintText: 'admin@fruitbari.com',
              ),
            ),

            const SizedBox(height: 16),

            // Password Field
            Text(
              lang == 'bn' ? 'গোপন পাসওয়ার্ড' : 'Security Password',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.key_rounded, color: AppColors.primaryDark),
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
                hintText: '••••••••••••',
              ),
            ),

            if (authState.authError != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authState.authError!,
                        style: const TextStyle(color: AppColors.error, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: authState.isLoading ? null : _handleAdminLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: authState.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.verified_user_rounded, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          lang == 'bn' ? 'অ্যাডমিন প্যানেলে প্রবেশ করুন' : 'Authenticate & Enter Admin Console',
                          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 20),

            // Demo Credentials Helper Hint
            Center(
              child: Text(
                'Demo Authorized Credentials:\nEmail: $kAuthorizedAdminEmail\nPassword: $kAuthorizedAdminPassword',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
