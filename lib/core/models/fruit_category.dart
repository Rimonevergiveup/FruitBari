class FruitCategory {
  final String id;
  final String nameEn;
  final String nameBn;
  final String iconEmoji;
  final String heroBannerTextEn;
  final String heroBannerTextBn;
  final List<int> peakSeasonMonths;

  const FruitCategory({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.iconEmoji,
    required this.heroBannerTextEn,
    required this.heroBannerTextBn,
    required this.peakSeasonMonths,
  });

  String getName(String lang) => lang == 'bn' ? nameBn : nameEn;
  String getBannerText(String lang) => lang == 'bn' ? heroBannerTextBn : heroBannerTextEn;
}

const List<FruitCategory> kFruitCategories = [
  FruitCategory(
    id: 'all',
    nameEn: 'All Fruits',
    nameBn: 'সব ফল',
    iconEmoji: '🧺',
    heroBannerTextEn: 'Discover Bangladesh’s sweetest seasonal harvests',
    heroBannerTextBn: 'বাংলাদেশের মিষ্টি ও সুস্বাদু মৌসুমি ফলের সমাহার',
    peakSeasonMonths: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
  ),
  FruitCategory(
    id: 'mangoes',
    nameEn: 'Mangoes',
    nameBn: 'আম',
    iconEmoji: '🥭',
    heroBannerTextEn: 'Rajshahi & Chapai Himsagar, Haribhanga & Amrapali',
    heroBannerTextBn: 'রাজশাহী ও চাঁপাইয়ের সেরা হিমসাগর, হাড়িভাঙা ও আম্রপালি',
    peakSeasonMonths: [5, 6, 7],
  ),
  FruitCategory(
    id: 'lychees',
    nameEn: 'Lychees',
    nameBn: 'লিচু',
    iconEmoji: '🍒',
    heroBannerTextEn: 'Dinajpur Bedana & China-3 Juicy Lychees',
    heroBannerTextBn: 'দিনাজপুরের মিষ্টি বেদানা ও চায়না-৩ লিচু',
    peakSeasonMonths: [5, 6],
  ),
  FruitCategory(
    id: 'pineapples',
    nameEn: 'Pineapples',
    nameBn: 'আনারস',
    iconEmoji: '🍍',
    heroBannerTextEn: 'Madhupur & Sreemangal Honey Queen Pineapples',
    heroBannerTextBn: 'মধুপুর ও শ্রীমঙ্গলের মিষ্টি হানিকুইন আনারস',
    peakSeasonMonths: [6, 7, 8, 9],
  ),
  FruitCategory(
    id: 'jackfruit',
    nameEn: 'Jackfruit',
    nameBn: 'কাঁঠাল',
    iconEmoji: '🍈',
    heroBannerTextEn: 'National Fruit of Bangladesh from Gazipur & Narsingdi',
    heroBannerTextBn: 'গাজীপুর ও নরসিংদীর মিষ্টি গালা ও খাজা কাঁঠাল',
    peakSeasonMonths: [6, 7, 8],
  ),
  FruitCategory(
    id: 'guavas',
    nameEn: 'Guavas',
    nameBn: 'পেয়ারা',
    iconEmoji: '🍐',
    heroBannerTextEn: 'Crisp & crunchy Thai Guava from Swarupkathi, Barisal',
    heroBannerTextBn: 'স্বরূপকাঠি ও বরিশালের সতেজ থাই ও কাজি পেয়ারা',
    peakSeasonMonths: [7, 8, 9, 10],
  ),
  FruitCategory(
    id: 'dragonfruit',
    nameEn: 'Dragon Fruit',
    nameBn: 'ড্রাগন ফল',
    iconEmoji: '🪷',
    heroBannerTextEn: 'Red & White fleshed Dragon Fruit from Jhenaidah',
    heroBannerTextBn: 'ঝিনাইদহ ও নাটোরের ভিটামিন সমৃদ্ধ লাল ড্রাগন ফল',
    peakSeasonMonths: [6, 7, 8, 9, 10],
  ),
  FruitCategory(
    id: 'bundles',
    nameEn: 'Curated Boxes',
    nameBn: 'ফ্রুট বক্স',
    iconEmoji: '🎁',
    heroBannerTextEn: 'Custom hand-picked gift crates & seasonal fruit samplers',
    heroBannerTextBn: 'উপহার ও পরিবারের জন্য বিশেষ প্রিমিয়াম ফলের বক্স',
    peakSeasonMonths: [5, 6, 7, 8],
  ),
];
