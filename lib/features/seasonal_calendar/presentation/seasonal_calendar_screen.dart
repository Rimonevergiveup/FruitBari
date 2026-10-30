import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/data/mock_fruit_data.dart';
import '../../../core/localization/locale_provider.dart';
import '../../home/presentation/widgets/product_card.dart';

class MonthInfo {
  final int number; // 1 to 12
  final String nameEn;
  final String nameBn;
  final String seasonEn;
  final String seasonBn;

  const MonthInfo({
    required this.number,
    required this.nameEn,
    required this.nameBn,
    required this.seasonEn,
    required this.seasonBn,
  });
}

const List<MonthInfo> kYearMonths = [
  MonthInfo(number: 1, nameEn: 'January', nameBn: 'জানুয়ারি (পৌষ-মাঘ)', seasonEn: 'Winter (Jujube/Boroi)', seasonBn: 'শীতকাল (বরই/কুল)'),
  MonthInfo(number: 2, nameEn: 'February', nameBn: 'ফেব্রুয়ারি (মাঘ-ফাল্গুন)', seasonEn: 'Late Winter', seasonBn: 'বসন্তের সূচনা'),
  MonthInfo(number: 3, nameEn: 'March', nameBn: 'March (ফাল্গুন-চৈত্র)', seasonEn: 'Spring (Watermelon begins)', seasonBn: 'বসন্তকাল (তরমুজের আগমন)'),
  MonthInfo(number: 4, nameEn: 'April', nameBn: 'April (চৈত্র-বৈশাখ)', seasonEn: 'Early Summer (Green Mangoes)', seasonBn: 'গ্রীষ্মকাল (কাঁচা আম/বাঙ্গি)'),
  MonthInfo(number: 5, nameEn: 'May', nameBn: 'May (বৈশাখ-জ্যৈষ্ঠ)', seasonEn: 'Peak Madhumash (Himsagar, Lychee)', seasonBn: 'মধুমাস (হিমসাগর, বেদানা লিচু)'),
  MonthInfo(number: 6, nameEn: 'June', nameBn: 'June (জ্যৈষ্ঠ-আষাঢ়)', seasonEn: 'Peak Mango & Jackfruit', seasonBn: 'আম, কাঁঠাল ও আনারসের ভরা মৌসুম'),
  MonthInfo(number: 7, nameEn: 'July', nameBn: 'July (আষাঢ়-শ্রাবণ)', seasonEn: 'Monsoon (Amrapali, Dragonfruit)', seasonBn: 'বর্ষাকাল (আম্রপালি, ড্রাগন, পেয়ারা)'),
  MonthInfo(number: 8, nameEn: 'August', nameBn: 'August (শ্রাবণ-ভাদ্র)', seasonEn: 'Guava, Dragonfruit & Late Mango', seasonBn: 'পেয়ারা, ড্রাগন ও ফজলি আম'),
  MonthInfo(number: 9, nameEn: 'September', nameBn: 'September (ভাদ্র-আশ্বিন)', seasonEn: 'Autumn (Ripe Papaya, Citrus)', seasonBn: 'শরৎকাল (পাকা পেঁপে, মাল্টা)'),
  MonthInfo(number: 10, nameEn: 'October', nameBn: 'October (আশ্বিন-কার্তিক)', seasonEn: 'Local Malta & Pomelo', seasonBn: 'দেশি মাল্টা ও জাম্বুরা'),
  MonthInfo(number: 11, nameEn: 'November', nameBn: 'November (কার্তিক-অগ্রহায়ণ)', seasonEn: 'Early Oranges & Winter Fruits', seasonBn: 'শীতের আগমন (কমলা ও জলপাই)'),
  MonthInfo(number: 12, nameEn: 'December', nameBn: 'December (অগ্রহায়ণ-পৌষ)', seasonEn: 'Sylhet Oranges & Sweet Boroi', seasonBn: 'সিলেটের খাঁটি কমলা ও বাউকুল'),
];

class SeasonalCalendarScreen extends ConsumerStatefulWidget {
  const SeasonalCalendarScreen({super.key});

  @override
  ConsumerState<SeasonalCalendarScreen> createState() => _SeasonalCalendarScreenState();
}

class _SeasonalCalendarScreenState extends ConsumerState<SeasonalCalendarScreen> {
  int _selectedMonthNumber = 6; // Default June (Peak Summer/Madhumash in BD)

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final activeMonth = kYearMonths.firstWhere((m) => m.number == _selectedMonthNumber);

    // Filter fruits for this month
    final matchingFruits = kMockFruits.where((f) {
      return f.seasonalMonths.contains(_selectedMonthNumber);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.tr('fruitCalendar')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Intro Header
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryLight.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'bn'
                              ? 'বাংলাদেশের ১২ মাসের ফলের সময়সূচি'
                              : 'Bangladesh 12-Month Harvest Matrix',
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          lang == 'bn'
                              ? 'মৌসুম অনুযায়ী বাগান থেকে সরাসরি তাজা ফলের নিশ্চয়তা।'
                              : 'Real seasonal cycles from certified regional agricultural data.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Month Selector
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: kYearMonths.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final month = kYearMonths[index];
                  final isSelected = month.number == _selectedMonthNumber;

                  return ChoiceChip(
                    label: Text(
                      lang == 'bn' ? month.nameBn.split(' ').first : month.nameEn,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontSize: 13,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : const Color(0xFFDDD7CC),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedMonthNumber = month.number;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Active Month Detail Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEDE8DF)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.accentSubtle,
                    child: Text(
                      '${activeMonth.number}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentWarm,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'bn' ? activeMonth.nameBn : activeMonth.nameEn,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        Text(
                          lang == 'bn' ? activeMonth.seasonBn : activeMonth.seasonEn,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.freshGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${matchingFruits.length} ${lang == 'bn' ? 'জাতের ফল' : 'Varieties'}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Products Grid for this Month
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                lang == 'bn'
                    ? '${activeMonth.nameBn.split(' ').first} মাসের তাজা ফলসমূহ'
                    : 'Fruits Harvested in ${activeMonth.nameEn}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 12),

            if (matchingFruits.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.nature_people_rounded, size: 50, color: AppColors.textMuted),
                      const SizedBox(height: 12),
                      Text(
                        lang == 'bn'
                            ? 'এই মাসে কোনো ফলের প্রধান মৌসুম নেই। অফ-সিজন সংরক্ষণ ও প্রি-অর্ডার চলছে।'
                            : 'No primary harvest scheduled for this month. Upcoming bookings open.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: matchingFruits.length,
                  itemBuilder: (context, index) {
                    return ProductCard(fruit: matchingFruits[index]);
                  },
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
