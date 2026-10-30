import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/localization/location_provider.dart';
import '../../../core/models/order.dart';
import '../../cart/controller/cart_controller.dart';
import '../../orders/controller/orders_controller.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController(text: 'House 14, Road 11, Block D');
  final _phoneController = TextEditingController(text: '01711223344');
  PaymentMethod _selectedPayment = PaymentMethod.cashOnDelivery;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final cartState = ref.read(cartProvider);
    final location = ref.read(locationProvider);
    final deliveryFee = location.deliveryFeeBDT;
    final discount = cartState.calculateDiscount();
    final total = cartState.calculateTotal(deliveryFee);

    // Simulate backend order reservation and validation
    await Future.delayed(const Duration(milliseconds: 700));

    final order = ref.read(ordersProvider.notifier).placeOrder(
          items: cartState.items,
          location: location,
          address: _addressController.text.trim(),
          phone: _phoneController.text.trim(),
          paymentMethod: _selectedPayment,
          subtotalBDT: cartState.subtotalBDT,
          deliveryFeeBDT: deliveryFee,
          discountBDT: discount,
          totalBDT: total,
          promoCode: cartState.appliedCoupon,
        );

    // Clear cart
    ref.read(cartProvider.notifier).clearCart();

    if (mounted) {
      context.go('/order-success/${order.orderId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final cartState = ref.watch(cartProvider);
    final location = ref.watch(locationProvider);

    final subtotal = cartState.subtotalBDT;
    final discount = cartState.calculateDiscount();
    final deliveryFee = location.deliveryFeeBDT;
    final total = cartState.calculateTotal(deliveryFee);

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.tr('checkout')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Area Confirmation
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_city_rounded, color: AppColors.primary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref.tr('deliveryTo'),
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          Text(
                            location.getDisplay(lang),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          Text(
                            '${location.estimatedHours} • ${ref.tr('deliveryFee')}: ৳$deliveryFee',
                            style: const TextStyle(fontSize: 11.5, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Detailed Delivery Address
              Text(
                ref.tr('deliveryAddress'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: ref.tr('addressHint'),
                  prefixIcon: const Icon(Icons.home_outlined, color: AppColors.primary),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return lang == 'bn' ? 'বিস্তারিত ঠিকানা লিখুন' : 'Please provide detailed delivery address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Contact Number
              Text(
                ref.tr('contactNumber'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '01XXXXXXXXX',
                  prefixIcon: Icon(Icons.phone_iphone_rounded, color: AppColors.primary),
                ),
                validator: (val) {
                  if (val == null || val.trim().length < 11) {
                    return lang == 'bn' ? '১১ ডিজিটের মোবাইল নম্বর দিন' : 'Enter valid 11-digit mobile number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Payment Method
              Text(
                ref.tr('paymentMethod'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 10),

              // Cash on Delivery Option
              _paymentOptionCard(
                method: PaymentMethod.cashOnDelivery,
                title: ref.tr('cod'),
                subtitle: ref.tr('codDesc'),
                icon: Icons.local_atm_rounded,
                badge: lang == 'bn' ? 'সবচেয়ে জনপ্রিয়' : 'Most Popular',
              ),
              const SizedBox(height: 10),

              // bKash / Digital Option
              _paymentOptionCard(
                method: PaymentMethod.bkash,
                title: ref.tr('bkash'),
                subtitle: ref.tr('bkashDesc'),
                icon: Icons.account_balance_wallet_rounded,
                badge: lang == 'bn' ? 'ক্যাশলেস' : 'Instant',
              ),

              const SizedBox(height: 24),

              // Final Order Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEDE8DF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang == 'bn' ? 'সর্বমোট বিবরণী' : 'Final Bill Breakdown',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _summaryLine(ref.tr('subtotal'), '৳$subtotal'),
                    const SizedBox(height: 6),
                    _summaryLine(ref.tr('deliveryFee'), '৳$deliveryFee'),
                    if (discount > 0) ...[
                      const SizedBox(height: 6),
                      _summaryLine(ref.tr('discount'), '-৳$discount', color: AppColors.freshGreen),
                    ],
                    const Divider(height: 18),
                    _summaryLine(
                      ref.tr('total'),
                      '৳$total',
                      isBold: true,
                      color: AppColors.primaryDark,
                      fontSize: 17,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _submitOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: _isSubmitting
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${ref.tr('placeOrder')} (৳$total)',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _paymentOptionCard({
    required PaymentMethod method,
    required String title,
    required String subtitle,
    required IconData icon,
    required String badge,
  }) {
    final isSelected = _selectedPayment == method;

    return InkWell(
      onTap: () {
        setState(() => _selectedPayment = method);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySurface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFEDE8DF),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 12),
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentSubtle,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentWarm,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryLine(
    String label,
    String value, {
    bool isBold = false,
    Color color = AppColors.textPrimary,
    double fontSize = 13.5,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? AppColors.primaryDark : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
