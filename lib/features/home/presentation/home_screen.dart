import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/data/mock_fruit_data.dart';
import '../../../core/localization/locale_provider.dart';
import '../../cart/controller/cart_controller.dart';
import 'widgets/category_chips.dart';
import 'widgets/featured_bundles.dart';
import 'widgets/in_season_tray.dart';
import 'widgets/product_card.dart';
import 'widgets/seasonal_hero_banner.dart';
import 'widgets/top_location_bar.dart';
import 'widgets/verified_farmer_section.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String q) {
    state = q;
  }

  void clear() {
    state = '';
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();
    final cartState = ref.watch(cartProvider);

    // Filter products according to category & search query
    final filteredFruits = kMockFruits.where((f) {
      final matchesCategory = selectedCategory == 'all' || f.categoryId == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          f.nameEn.toLowerCase().contains(searchQuery) ||
          f.nameBn.contains(searchQuery) ||
          f.varietyEn.toLowerCase().contains(searchQuery) ||
          f.varietyBn.contains(searchQuery) ||
          f.originEn.toLowerCase().contains(searchQuery) ||
          f.originBn.contains(searchQuery) ||
          f.seller.nameEn.toLowerCase().contains(searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top Bar with Location, Language toggle & Cart
            const SliverToBoxAdapter(
              child: TopLocationBar(),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: TextField(
                  onChanged: (val) {
                    ref.read(searchQueryProvider.notifier).setQuery(val);
                  },
                  decoration: InputDecoration(
                    hintText: ref.tr('searchHint'),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              ref.read(searchQueryProvider.notifier).clear();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            // Category Chips
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CategoryChips(),
              ),
            ),

            // Only show Banners & Discovery Rails if no search query is active
            if (searchQuery.isEmpty && selectedCategory == 'all') ...[
              // Seasonal Hero Banner
              const SliverToBoxAdapter(
                child: SeasonalHeroBanner(),
              ),

              // In Season Now Showcase
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 16),
                  child: InSeasonTray(),
                ),
              ),

              // Curated Gift Crates & Bundles
              const SliverToBoxAdapter(
                child: FeaturedBundles(),
              ),

              // Verified Farmer Heritage Section
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: VerifiedFarmerSection(),
                ),
              ),
            ],

            // Catalog Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      searchQuery.isNotEmpty
                          ? '${lang == 'bn' ? 'অনুসন্ধানের ফলাফল' : 'Search Results'} (${filteredFruits.length})'
                          : ref.tr('popularSeasonal'),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    if (searchQuery.isEmpty)
                      InkWell(
                        onTap: () => context.push('/calendar'),
                        child: Text(
                          ref.tr('fruitCalendar'),
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Main Product Grid
            if (filteredFruits.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(48),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.search_off_rounded, size: 56, color: AppColors.textMuted),
                        const SizedBox(height: 12),
                        Text(
                          lang == 'bn'
                              ? 'কোনো ফল পাওয়া যায়নি'
                              : 'No matching seasonal fruits found',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductCard(fruit: filteredFruits[index]);
                    },
                    childCount: filteredFruits.length,
                  ),
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 36),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Home - already here
              break;
            case 1:
              context.push('/calendar');
              break;
            case 2:
              context.push('/cart');
              break;
            case 3:
              context.push('/orders');
              break;
            case 4:
              context.push('/profile');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.eco_outlined),
            activeIcon: const Icon(Icons.eco_rounded),
            label: lang == 'bn' ? 'হোম' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            activeIcon: const Icon(Icons.calendar_month_rounded),
            label: lang == 'bn' ? 'ক্যালেন্ডার' : 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: cartState.totalItemsCount > 0,
              label: Text('${cartState.totalItemsCount}'),
              backgroundColor: AppColors.accent,
              textColor: Colors.black,
              child: const Icon(Icons.shopping_basket_outlined),
            ),
            activeIcon: Badge(
              isLabelVisible: cartState.totalItemsCount > 0,
              label: Text('${cartState.totalItemsCount}'),
              backgroundColor: AppColors.accent,
              textColor: Colors.black,
              child: const Icon(Icons.shopping_basket_rounded),
            ),
            label: ref.tr('cart'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_long_outlined),
            activeIcon: const Icon(Icons.receipt_long_rounded),
            label: lang == 'bn' ? 'অর্ডার' : 'Orders',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            activeIcon: const Icon(Icons.person_rounded),
            label: lang == 'bn' ? 'প্রোফাইল' : 'Profile',
          ),
        ],
      ),
    );
  }
}
