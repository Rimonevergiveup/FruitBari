import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/mock_fruit_data.dart';
import '../../../../core/localization/locale_provider.dart';
import 'product_card.dart';

class InSeasonTray extends ConsumerWidget {
  const InSeasonTray({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inSeasonFruits = kMockFruits.where((f) => f.isInSeason).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.eco_rounded, size: 20, color: AppColors.freshGreen),
                      const SizedBox(width: 6),
                      Text(
                        ref.tr('inSeasonNow'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ref.tr('inSeasonSubtitle'),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => context.push('/calendar'),
                child: Text(
                  ref.tr('viewAll'),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 235,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: inSeasonFruits.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 170,
                child: ProductCard(
                  fruit: inSeasonFruits[index],
                  compact: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
