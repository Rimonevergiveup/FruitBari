import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/data/mock_fruit_data.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/widgets/fruitbari_logo.dart';
import '../../auth/controller/auth_controller.dart';

class SellerDashboardScreen extends ConsumerStatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  ConsumerState<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends ConsumerState<SellerDashboardScreen> {
  void _showAddFruitDialog(BuildContext context, String lang) {
    final nameController = TextEditingController();
    final varietyController = TextEditingController();
    final priceController = TextEditingController(text: '150');
    final stockController = TextEditingController(text: '200');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            lang == 'bn' ? 'নতুন মৌসুমি ফল যুক্ত করুন' : 'List Seasonal Harvest',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: lang == 'bn' ? 'ফলের নাম' : 'Fruit Name',
                    hintText: 'e.g. Rajshahi Langra Mango',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: varietyController,
                  decoration: InputDecoration(
                    labelText: lang == 'bn' ? 'জাত / ভ্যারাইটি' : 'Variety',
                    hintText: 'e.g. Langra Select',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: lang == 'bn' ? 'মূল্য (৳/কেজি)' : 'Price (৳/kg)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: stockController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: lang == 'bn' ? 'মজুদ (কেজি)' : 'Stock (kg)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.freshGreen),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          lang == 'bn' ? 'শতভাগ কার্বাইডমুক্ত ও গাছপাকা প্রত্যয়ন' : 'Certified 0% Carbide & Tree-Ripened',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(lang == 'bn' ? 'বাতিল' : 'Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      lang == 'bn'
                          ? '${nameController.text.isEmpty ? 'নতুন ফল' : nameController.text} সফলভাবে লিস্টিং এ যুক্ত হয়েছে!'
                          : 'Fruit listing published successfully to FruitBari catalog!',
                    ),
                    backgroundColor: AppColors.freshGreen,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: Text(lang == 'bn' ? 'লিস্টিং প্রকাশ করুন' : 'Publish Listing'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);

    // Guard: Must be logged in as seller
    if (!authState.isSeller) {
      return Scaffold(
        appBar: AppBar(title: const Text('Farmer Portal')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FruitBariLogo.symbol(width: 56, height: 56),
                const SizedBox(height: 16),
                const Text(
                  'Seller Portal Access Required',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please sign in with your verified FruitBari farmer or orchard account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.go('/auth/seller'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentWarm),
                  child: const Text('Seller Login'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final user = authState.currentUser!;
    final isApproved = user.isSellerApproved;

    // Filter fruits for this orchard (or show sample harvests)
    final orchardFruits = kMockFruits.where((f) => f.seller.id == 'farmer_fazlur').toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FruitBariLogo.symbol(width: 28, height: 28),
            const SizedBox(width: 8),
            Text(lang == 'bn' ? 'চাষি ড্যাশবোর্ড' : 'Farmer Dashboard'),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.storefront_rounded),
          onPressed: () => context.go('/'),
          tooltip: 'Back to Customer Store',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/auth');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Orchard Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF335C48), AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(user.avatarUrl ?? 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=200'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.shopName ?? 'Registered Orchard',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${user.name} • ${user.shopLocation ?? 'Bangladesh'}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isApproved ? AppColors.freshGreen : AppColors.accent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isApproved
                                ? (lang == 'bn' ? '✓ যাচাইকৃত অনুমোদিত বাগান' : '✓ Verified & Approved Orchard')
                                : (lang == 'bn' ? '⏳ অনুমোদন প্রক্রিয়াধীন' : '⏳ Verification Pending'),
                            style: TextStyle(
                              color: isApproved ? Colors.white : Colors.black,
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Short Approval Step Notice if Pending
            if (!isApproved) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentSubtle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.accent.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.hourglass_top_rounded, color: AppColors.accentWarm, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          lang == 'bn' ? 'আবেদন অনুমোদনের অপেক্ষায় রয়েছে' : 'Registration Under Administrative Review',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lang == 'bn'
                          ? 'ফ্রুটবাড়িতে ফল লিস্টিং করার পূর্বে প্রতিটি বাগানের সঠিকতা ও কার্বাইডমুক্ত পদ্ধতি নিশ্চিত করতে প্রশাসক যাচাই করেন। অনুমোদন সম্পন্ন হলে সরাসরি ফল যুক্ত করার বোতামটি সক্রিয় হবে।'
                          : 'To maintain platform authenticity and zero-carbide quality, FruitBari administrators verify orchard details before listings can be published.',
                      style: const TextStyle(fontSize: 12.5, color: AppColors.textPrimary, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Quick convenience action for evaluation: Admin can approve
                        ref.read(authProvider.notifier).approveSeller(user.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Demo: Orchard approved by FruitBari Admin!'),
                            backgroundColor: AppColors.freshGreen,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      icon: const Icon(Icons.check_circle_outline, size: 16),
                      label: Text(
                        lang == 'bn' ? 'ডেমো: তাৎক্ষণিক অনুমোদন করুন' : 'Demo Action: Instant Approve',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Action Header with "Add Seasonal Fruit" button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lang == 'bn' ? 'আপনার ফল তালিকা' : 'Your Harvest Listings',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: isApproved
                      ? () => _showAddFruitDialog(context, lang)
                      : null, // Disabled when pending approval!
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    lang == 'bn' ? 'নতুন ফল যুক্ত করুন' : 'Add Seasonal Fruit',
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Listings Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orchardFruits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final fruit = orchardFruits[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEDE8DF)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          fruit.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fruit.getName(lang),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              '${fruit.getVariety(lang)} • ${fruit.stockQuantity} kg in stock',
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '৳${fruit.basePriceBDT}/${fruit.getBaseUnit(lang)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primarySurface,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Active on Market',
                                    style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
