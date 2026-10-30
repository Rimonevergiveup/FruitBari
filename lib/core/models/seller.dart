class Seller {
  final String id;
  final String nameEn;
  final String nameBn;
  final String orchardNameEn;
  final String orchardNameBn;
  final String districtEn;
  final String districtBn;
  final double rating;
  final int totalReviews;
  final bool isVerifiedFarmer;
  final String badgeTextEn;
  final String badgeTextBn;
  final String avatarUrl;

  const Seller({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.orchardNameEn,
    required this.orchardNameBn,
    required this.districtEn,
    required this.districtBn,
    required this.rating,
    required this.totalReviews,
    required this.isVerifiedFarmer,
    required this.badgeTextEn,
    required this.badgeTextBn,
    required this.avatarUrl,
  });

  String getName(String lang) => lang == 'bn' ? nameBn : nameEn;
  String getOrchard(String lang) => lang == 'bn' ? orchardNameBn : orchardNameEn;
  String getDistrict(String lang) => lang == 'bn' ? districtBn : districtEn;
  String getBadge(String lang) => lang == 'bn' ? badgeTextBn : badgeTextEn;
}
