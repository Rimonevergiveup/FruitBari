import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_provider.dart';

class SeasonalHeroBanner extends ConsumerWidget {
  const SeasonalHeroBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryDark,
            AppColors.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wb_sunny_rounded, size: 14, color: Colors.black87),
                const SizedBox(width: 4),
                Text(
                  lang == 'bn' ? 'মধুমাস বৈশাখ-জ্যৈষ্ঠ উৎসব' : 'Madhumash Harvest Season',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Main Headline
          Text(
            lang == 'bn'
                ? 'বাগান থেকে গাছপাকা আম ও রসালো লিচু'
                : 'Tree-Ripened Mangoes & Juicy Dinajpur Lychees',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            lang == 'bn'
                ? 'চাঁপাই ও দিনাজপুরের বিশ্বস্ত কৃষকদের থেকে সরাসরি আপনার দরজায়। ১০০% প্রাকৃতিক নিশ্চয়তা।'
                : 'Directly sourced from certified orchardists in Chapai & Dinajpur with zero carbide guarantee.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.88),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons: Discover & Fruit Calendar
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/calendar');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.calendar_month_rounded, size: 16),
                label: Text(
                  lang == 'bn' ? 'ফলের ক্যালেন্ডার' : 'Fruit Calendar',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  // Scroll or focus on discovery
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withOpacity(0.6)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  lang == 'bn' ? 'তাজা অফার' : 'Fresh Offers',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
