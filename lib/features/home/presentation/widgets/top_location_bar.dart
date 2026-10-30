import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../core/localization/location_provider.dart';
import '../../../../core/widgets/fruitbari_logo.dart';
import '../../../cart/controller/cart_controller.dart';

class TopLocationBar extends ConsumerWidget {
  const TopLocationBar({super.key});

  void _showLocationPicker(BuildContext context, WidgetRef ref) {
    final lang = ref.read(localeProvider);
    final currentLocation = ref.read(locationProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.place_rounded, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      ref.tr('deliveryTo'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: kSupportedLocations.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final loc = kSupportedLocations[index];
                      final isSelected = loc.id == currentLocation.id;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          isSelected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
                          color: isSelected ? AppColors.primary : Colors.grey,
                        ),
                        title: Text(
                          loc.getDisplay(lang),
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          '${loc.estimatedHours} • ${ref.tr('deliveryFee')}: ৳${loc.deliveryFeeBDT}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        onTap: () {
                          ref.read(locationProvider.notifier).setLocation(loc);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final location = ref.watch(locationProvider);
    final cartState = ref.watch(cartProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.scaffoldBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Brand & Quick Actions Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FruitBari Official Compact Logo
              const FruitBariLogo.compact(height: 34),

              // Action Buttons Row (Language, Role Portal, Cart)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bilingual Toggle Button (BN / EN)
                  InkWell(
                    onTap: () {
                      ref.read(localeProvider.notifier).toggleLocale();
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language_rounded, size: 14, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            lang == 'en' ? 'বাংলা' : 'EN',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Role / Portal Entry Button
                  InkWell(
                    onTap: () => context.push('/auth'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2DDD2)),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        size: 20,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Cart Quick Icon with Badge
                  InkWell(
                    onTap: () => context.push('/cart'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2DDD2)),
                      ),
                      child: Badge(
                        isLabelVisible: cartState.totalItemsCount > 0,
                        label: Text('${cartState.totalItemsCount}'),
                        backgroundColor: AppColors.accent,
                        textColor: Colors.black,
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 20,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Delivery Location Selector Pill
          InkWell(
            onTap: () => _showLocationPicker(context, ref),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2DDD2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.place_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${ref.tr('deliveryTo')}: ',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          location.getDisplay(lang),
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ${location.estimatedHours}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
