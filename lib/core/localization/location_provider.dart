import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryLocation {
  final String id;
  final String areaEn;
  final String areaBn;
  final String districtEn;
  final String districtBn;
  final int deliveryFeeBDT;
  final String estimatedHours;

  const DeliveryLocation({
    required this.id,
    required this.areaEn,
    required this.areaBn,
    required this.districtEn,
    required this.districtBn,
    required this.deliveryFeeBDT,
    required this.estimatedHours,
  });

  String getDisplay(String lang) {
    if (lang == 'bn') {
      return '$areaBn, $districtBn';
    }
    return '$areaEn, $districtEn';
  }
}

const List<DeliveryLocation> kSupportedLocations = [
  DeliveryLocation(
    id: 'dhaka_gulshan',
    areaEn: 'Gulshan & Banani',
    areaBn: 'গুলশান ও বনানী',
    districtEn: 'Dhaka',
    districtBn: 'ঢাকা',
    deliveryFeeBDT: 60,
    estimatedHours: 'Same day (3-5 hrs)',
  ),
  DeliveryLocation(
    id: 'dhaka_dhanmondi',
    areaEn: 'Dhanmondi',
    areaBn: 'ধানমন্ডি',
    districtEn: 'Dhaka',
    districtBn: 'ঢাকা',
    deliveryFeeBDT: 60,
    estimatedHours: 'Same day (3-5 hrs)',
  ),
  DeliveryLocation(
    id: 'dhaka_uttara',
    areaEn: 'Uttara',
    areaBn: 'উত্তরা',
    districtEn: 'Dhaka',
    districtBn: 'ঢাকা',
    deliveryFeeBDT: 70,
    estimatedHours: 'Same day (4-6 hrs)',
  ),
  DeliveryLocation(
    id: 'dhaka_mirpur',
    areaEn: 'Mirpur',
    areaBn: 'মিরপুর',
    districtEn: 'Dhaka',
    districtBn: 'ঢাকা',
    deliveryFeeBDT: 70,
    estimatedHours: 'Same day (4-6 hrs)',
  ),
  DeliveryLocation(
    id: 'chittagong_gec',
    areaEn: 'GEC Circle & Nasirabad',
    areaBn: 'জিইসি মোড় ও নাসিরাবাদ',
    districtEn: 'Chattogram',
    districtBn: 'চট্টগ্রাম',
    deliveryFeeBDT: 90,
    estimatedHours: 'Next day morning',
  ),
  DeliveryLocation(
    id: 'sylhet_sadar',
    areaEn: 'Zindabazar & Upashahar',
    areaBn: 'জিন্দাবাজার ও উপশহর',
    districtEn: 'Sylhet',
    districtBn: 'সিলেট',
    deliveryFeeBDT: 100,
    estimatedHours: '24-36 hrs',
  ),
  DeliveryLocation(
    id: 'rajshahi_sadar',
    areaEn: 'Shaheb Bazar & Kazihata',
    areaBn: 'সাহেব বাজার ও কাজিহাটা',
    districtEn: 'Rajshahi',
    districtBn: 'রাজশাহী',
    deliveryFeeBDT: 50,
    estimatedHours: 'Direct orchard dispatch (2 hrs)',
  ),
];

class LocationNotifier extends Notifier<DeliveryLocation> {
  @override
  DeliveryLocation build() => kSupportedLocations.first;

  void setLocation(DeliveryLocation loc) {
    state = loc;
  }
}

final locationProvider = NotifierProvider<LocationNotifier, DeliveryLocation>(() {
  return LocationNotifier();
});
