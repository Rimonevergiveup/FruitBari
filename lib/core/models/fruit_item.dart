import 'seller.dart';

class WeightOption {
  final String labelEn;
  final String labelBn;
  final double multiplier; // Multiplier against base price
  final String unitCode; // 'kg', 'g', 'crate', 'pcs'

  const WeightOption({
    required this.labelEn,
    required this.labelBn,
    required this.multiplier,
    required this.unitCode,
  });

  String getLabel(String lang) => lang == 'bn' ? labelBn : labelEn;
}

class FruitItem {
  final String id;
  final String nameEn;
  final String nameBn;
  final String categoryId; // 'mangoes', 'lychees', 'jackfruit', 'pineapples', etc.
  final String varietyEn;
  final String varietyBn;
  final String originEn;
  final String originBn;
  final Seller seller;
  final int basePriceBDT; // Base price for default unit (e.g. 1 kg)
  final String baseUnitEn;
  final String baseUnitBn;
  final List<WeightOption> weightOptions;
  final int stockQuantity;
  final double rating;
  final int reviewCount;
  final String descriptionEn;
  final String descriptionBn;
  final String storageTipsEn;
  final String storageTipsBn;
  final String harvestTimeEn;
  final String harvestTimeBn;
  final List<int> seasonalMonths; // 1 to 12
  final bool isInSeason;
  final bool isPeakSeason;
  final bool isArrivingSoon;
  final bool isCarbideFreeVerified;
  final String qualityGradeEn;
  final String qualityGradeBn;
  final String imageUrl;
  final List<String> galleryUrls;
  final bool isFeaturedBundle;

  const FruitItem({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.categoryId,
    required this.varietyEn,
    required this.varietyBn,
    required this.originEn,
    required this.originBn,
    required this.seller,
    required this.basePriceBDT,
    required this.baseUnitEn,
    required this.baseUnitBn,
    required this.weightOptions,
    required this.stockQuantity,
    required this.rating,
    required this.reviewCount,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.storageTipsEn,
    required this.storageTipsBn,
    required this.harvestTimeEn,
    required this.harvestTimeBn,
    required this.seasonalMonths,
    required this.isInSeason,
    required this.isPeakSeason,
    this.isArrivingSoon = false,
    this.isCarbideFreeVerified = true,
    required this.qualityGradeEn,
    required this.qualityGradeBn,
    required this.imageUrl,
    this.galleryUrls = const [],
    this.isFeaturedBundle = false,
  });

  String getName(String lang) => lang == 'bn' ? nameBn : nameEn;
  String getVariety(String lang) => lang == 'bn' ? varietyBn : varietyEn;
  String getOrigin(String lang) => lang == 'bn' ? originBn : originEn;
  String getBaseUnit(String lang) => lang == 'bn' ? baseUnitBn : baseUnitEn;
  String getDescription(String lang) => lang == 'bn' ? descriptionBn : descriptionEn;
  String getStorageTips(String lang) => lang == 'bn' ? storageTipsBn : storageTipsEn;
  String getHarvestTime(String lang) => lang == 'bn' ? harvestTimeBn : harvestTimeEn;
  String getQualityGrade(String lang) => lang == 'bn' ? qualityGradeBn : qualityGradeEn;

  int calculatePrice(WeightOption option) {
    return (basePriceBDT * option.multiplier).round();
  }
}
