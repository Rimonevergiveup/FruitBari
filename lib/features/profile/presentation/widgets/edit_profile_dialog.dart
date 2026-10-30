import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../core/localization/location_provider.dart';
import '../../../../core/models/user_model.dart';
import '../../../auth/controller/auth_controller.dart';

const List<String> kAvailableFruitAvatars = [
  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&auto=format&fit=crop&q=80',
  'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200&auto=format&fit=crop&q=80',
];

class EditProfileDialog extends ConsumerStatefulWidget {
  final UserModel currentUser;

  const EditProfileDialog({
    super.key,
    required this.currentUser,
  });

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late String _selectedDistrict;
  late String _selectedAvatarUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUser.name);
    _addressController = TextEditingController(text: widget.currentUser.deliveryAddress ?? 'House 14, Road 11, Block D');
    _selectedDistrict = widget.currentUser.district ?? kSupportedLocations.first.getDisplay('en');
    _selectedAvatarUrl = widget.currentUser.avatarUrl ?? kAvailableFruitAvatars.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    ref.read(authProvider.notifier).updateCustomerProfile(
          name: _nameController.text,
          avatarUrl: _selectedAvatarUrl,
          deliveryAddress: _addressController.text,
          district: _selectedDistrict,
        );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile details updated successfully!'),
        backgroundColor: AppColors.freshGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lang == 'bn' ? 'প্রোফাইল তথ্য পরিবর্তন' : 'Edit Customer Profile',
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Select Avatar
            Text(
              lang == 'bn' ? 'প্রোফাইল ছবি নির্বাচন করুন' : 'Select Profile Avatar',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: kAvailableFruitAvatars.map((url) {
                final isSelected = url == _selectedAvatarUrl;
                return InkWell(
                  onTap: () => setState(() => _selectedAvatarUrl = url),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // Name
            Text(
              lang == 'bn' ? 'আপনার নাম' : 'Full Name',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
                isDense: true,
              ),
            ),

            const SizedBox(height: 14),

            // Delivery Address
            Text(
              lang == 'bn' ? 'ডেলিভারি ঠিকানা' : 'Delivery Address',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.home_outlined, color: AppColors.primary),
                isDense: true,
              ),
            ),

            const SizedBox(height: 14),

            // Delivery Area / District
            Text(
              lang == 'bn' ? 'এলাকা ও জেলা' : 'Area & District',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: kSupportedLocations.any((l) => l.getDisplay('en') == _selectedDistrict)
                  ? _selectedDistrict
                  : kSupportedLocations.first.getDisplay('en'),
              isExpanded: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary),
                isDense: true,
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

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(lang == 'bn' ? 'বাতিল' : 'Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: Text(lang == 'bn' ? 'সংরক্ষণ করুন' : 'Save Changes'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
