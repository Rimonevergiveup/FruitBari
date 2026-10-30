import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/localization/location_provider.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../controller/auth_controller.dart';

class CustomerLoginScreen extends ConsumerStatefulWidget {
  final bool initialIsRegister;

  const CustomerLoginScreen({
    super.key,
    this.initialIsRegister = false,
  });

  @override
  ConsumerState<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends ConsumerState<CustomerLoginScreen> {
  late bool _isRegister;
  final _nameController = TextEditingController(text: 'Tanvir Ahmed');
  final _contactController = TextEditingController(text: '01711-223344');
  final _passwordController = TextEditingController(text: 'password123');
  final _addressController = TextEditingController(text: 'House 14, Road 11, Block D');
  String _selectedDistrict = 'Gulshan & Banani, Dhaka';

  @override
  void initState() {
    super.initState();
    _isRegister = widget.initialIsRegister;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submit() async {
    final authNotifier = ref.read(authProvider.notifier);
    bool success;

    if (_isRegister) {
      success = await authNotifier.registerCustomer(
        name: _nameController.text,
        emailOrPhone: _contactController.text,
        password: _passwordController.text,
        deliveryAddress: _addressController.text,
        district: _selectedDistrict,
      );
    } else {
      success = await authNotifier.loginCustomer(
        emailOrPhone: _contactController.text,
        password: _passwordController.text,
      );
    }

    if (success && mounted) {
      context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isRegister
            ? (lang == 'bn' ? 'ক্রেতা নিবন্ধন' : 'Customer Sign Up')
            : (lang == 'bn' ? 'ক্রেতা লগইন' : 'Customer Sign In')),
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
            // FruitBari Brand Header
            const Center(
              child: FruitBariLogo.compact(height: 38),
            ),
            const SizedBox(height: 20),

            // Mode Toggle Switcher
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _isRegister = false),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !_isRegister ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            lang == 'bn' ? 'লগইন' : 'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.5,
                              color: !_isRegister ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _isRegister = true),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _isRegister ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            lang == 'bn' ? 'নতুন অ্যাকাউন্ট' : 'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.5,
                              color: _isRegister ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (_isRegister) ...[
              Text(
                lang == 'bn' ? 'আপনার নাম' : 'Full Name',
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
                  hintText: 'e.g. Tanvir Ahmed',
                ),
              ),
              const SizedBox(height: 16),
            ],

            Text(
              lang == 'bn' ? 'মোবাইল নম্বর অথবা ইমেইল' : 'Mobile (+880) or Email',
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_iphone_rounded, color: AppColors.primary),
                hintText: '01XXXXXXXXX or customer@gmail.com',
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
                prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                hintText: '••••••••',
              ),
            ),

            if (_isRegister) ...[
              const SizedBox(height: 16),
              Text(
                lang == 'bn' ? 'ডেলিভারি ঠিকানা' : 'Delivery Address',
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.home_outlined, color: AppColors.primary),
                  hintText: 'House / Road / Block / Area',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                lang == 'bn' ? 'এলাকা ও জেলা' : 'Delivery Area / District',
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary),
                ),
                items: kSupportedLocations.map((loc) {
                  return DropdownMenuItem(
                    value: loc.getDisplay('en'),
                    child: Text(loc.getDisplay(lang), style: const TextStyle(fontSize: 13)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedDistrict = val);
                  }
                },
              ),
            ],

            if (authState.authError != null) ...[
              const SizedBox(height: 14),
              Text(
                authState.authError!,
                style: const TextStyle(color: AppColors.error, fontSize: 12),
              ),
            ],

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: authState.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
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
                      _isRegister
                          ? (lang == 'bn' ? 'অ্যাকাউন্ট তৈরি করুন' : 'Create Customer Account')
                          : (lang == 'bn' ? 'লগইন করুন' : 'Sign In as Customer'),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
