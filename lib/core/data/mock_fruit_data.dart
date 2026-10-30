import '../models/fruit_item.dart';
import '../models/seller.dart';

// Verified Farmers across key fruit hubs in Bangladesh
const Seller kFarmerFazlur = Seller(
  id: 'farmer_fazlur',
  nameEn: 'Haji Fazlur Rahman',
  nameBn: 'হাজী ফজলুর রহমান',
  orchardNameEn: 'Rohanpur Mango Heritage Orchard',
  orchardNameBn: 'রোহনপুর ম্যাঙ্গো হেরিটেজ বাগান',
  districtEn: 'Chapainawabganj',
  districtBn: 'চাঁপাইনবাবগঞ্জ',
  rating: 4.9,
  totalReviews: 248,
  isVerifiedFarmer: true,
  badgeTextEn: '3rd Gen Orchardist • 0% Carbide',
  badgeTextBn: '৩য় প্রজন্মের চাষি • কার্বাইডমুক্ত নিশ্চয়তা',
  avatarUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=200&auto=format&fit=crop&q=80',
);

const Seller kFarmerAnwar = Seller(
  id: 'farmer_anwar',
  nameEn: 'Anwar Hussain',
  nameBn: 'আনোয়ার হোসেন',
  orchardNameEn: 'Mithapukur Haribhanga Agro',
  orchardNameBn: 'মিঠাপুকুর হাড়িভাঙা এগ্রো',
  districtEn: 'Rangpur',
  districtBn: 'রংপুর',
  rating: 4.8,
  totalReviews: 185,
  isVerifiedFarmer: true,
  badgeTextEn: 'GI Tagged Region • Naturally Ripened',
  badgeTextBn: 'জিআই ট্যাগ প্রাপ্ত এলাকা • গাছপাকা',
  avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
);

const Seller kFarmerPranesh = Seller(
  id: 'farmer_pranesh',
  nameEn: 'Pranesh Sangma',
  nameBn: 'প্রনেশ সাংমা',
  orchardNameEn: 'Madhupur Red Clay Hill Pineapples',
  orchardNameBn: 'মধুপুর লালমাটি হিল আনারস বাগান',
  districtEn: 'Tangail',
  districtBn: 'টাঙ্গাইল',
  rating: 4.9,
  totalReviews: 142,
  isVerifiedFarmer: true,
  badgeTextEn: 'Organic Honey Queen • Hill Sourced',
  badgeTextBn: 'অর্গানিক হানিকুইন • পাহাড়ি বাগান',
  avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&auto=format&fit=crop&q=80',
);

const Seller kFarmerBiplob = Seller(
  id: 'farmer_biplob',
  nameEn: 'Biplob Roy',
  nameBn: 'বিপ্লব রায়',
  orchardNameEn: 'Mashimpur Royal Lychee Orchard',
  orchardNameBn: 'মাশিমপুর রয়্যাল লিচু বাগান',
  districtEn: 'Dinajpur',
  districtBn: 'দিনাজপুর',
  rating: 5.0,
  totalReviews: 310,
  isVerifiedFarmer: true,
  badgeTextEn: 'Famous Bedana Specialist',
  badgeTextBn: 'বিখ্যাত বেদানা লিচু স্পেশালিস্ট',
  avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&auto=format&fit=crop&q=80',
);

const Seller kFarmerZakir = Seller(
  id: 'farmer_zakir',
  nameEn: 'Zakir Hossain',
  nameBn: 'জাকির হোসেন',
  orchardNameEn: 'Barendra Dragon & Guava Farm',
  orchardNameBn: 'বারিন্দ ড্রাগন ও পেয়ারা ফার্ম',
  districtEn: 'Jhenaidah',
  districtBn: 'ঝিনাইদহ',
  rating: 4.7,
  totalReviews: 96,
  isVerifiedFarmer: true,
  badgeTextEn: 'Export Grade • Tree Harvested',
  badgeTextBn: 'রপ্তানি মান • সতেজ সংগৃহীত',
  avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200&auto=format&fit=crop&q=80',
);

// Seasonal Fruits Dataset
final List<FruitItem> kMockFruits = [
  FruitItem(
    id: 'fruit_himsagar_01',
    nameEn: 'Chapainawabganj Himsagar Mango',
    nameBn: 'চাঁপাইনবাবগঞ্জের আসল হিমসাগর আম',
    categoryId: 'mangoes',
    varietyEn: 'Himsagar (Khirsapat)',
    varietyBn: 'হিমসাগর (ক্ষীরশাপাত)',
    originEn: 'Rohanpur, Chapainawabganj',
    originBn: 'রোহনপুর, চাঁপাইনবাবগঞ্জ',
    seller: kFarmerFazlur,
    basePriceBDT: 140, // per 1 kg
    baseUnitEn: '1 kg',
    baseUnitBn: '১ কেজি',
    weightOptions: const [
      WeightOption(labelEn: '1 kg Sample', labelBn: '১ কেজি', multiplier: 1.0, unitCode: 'kg'),
      WeightOption(labelEn: '3 kg Family Pack', labelBn: '৩ কেজি ফ্যামিলি প্যাক', multiplier: 2.9, unitCode: 'kg'),
      WeightOption(labelEn: '5 kg Wooden Crate', labelBn: '৫ কেজি উডেন ক্রেট', multiplier: 4.8, unitCode: 'crate'),
      WeightOption(labelEn: '10 kg Master Crate', labelBn: '১০ কেজি মাস্টার ক্রেট', multiplier: 9.2, unitCode: 'crate'),
    ],
    stockQuantity: 450,
    rating: 4.9,
    reviewCount: 312,
    descriptionEn:
        'Certified GI (Geographical Indication) Khirsapat Himsagar. Known for its ultra-smooth, fiberless, buttery sweet orange pulp and heavenly aroma. Sourced tree-ripened from ancient orchards with strict zero-chemical assurance.',
    descriptionBn:
        'জিআই সনদপ্রাপ্ত চাঁপাইনবাবগঞ্জের খাঁটি ক্ষীরশাপাত হিমসাগর। সম্পূর্ণ আঁশমুক্ত, অত্যন্ত মিষ্টি ও সুবাসিত। গাছপাকা অবস্থায় সতর্কতার সাথে নামানো এবং কেমিক্যাল ছাড়া সুরক্ষিত ডেলিভারি।',
    storageTipsEn: 'Keep in airy bamboo basket at room temperature. Consume within 3-4 days of full aroma development.',
    storageTipsBn: 'খোলা বাতাসে রাখুন। তীব্র সুবাস ছড়ালে ৩-৪ দিনের মধ্যে খাওয়ার উপযোগী।',
    harvestTimeEn: 'Harvested yesterday dawn',
    harvestTimeBn: 'গতকাল ভোরে গাছ থেকে পাড়া',
    seasonalMonths: [5, 6, 7], // May to July
    isInSeason: true,
    isPeakSeason: true,
    qualityGradeEn: 'Grade A+ Premium Export Quality',
    qualityGradeBn: 'এ+ গ্রেড প্রিমিয়াম এক্সপোর্ট কোয়ালিটি',
    imageUrl: 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=800&auto=format&fit=crop&q=80',
    galleryUrls: [
      'https://images.unsplash.com/photo-1553279768-865429fa0078?w=800&auto=format&fit=crop&q=80',
      'https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?w=800&auto=format&fit=crop&q=80',
    ],
  ),

  FruitItem(
    id: 'fruit_bedana_lychee_02',
    nameEn: 'Dinajpur Bedana Lychee',
    nameBn: 'দিনাজপুরের ঐতিহ্যবাহী বেদানা লিচু',
    categoryId: 'lychees',
    varietyEn: 'Bedana Special',
    varietyBn: 'বেদানা স্পেশাল',
    originEn: 'Mashimpur, Dinajpur',
    originBn: 'মাশিমপুর, দিনাজপুর',
    seller: kFarmerBiplob,
    basePriceBDT: 480, // per 50 pcs
    baseUnitEn: '50 pcs',
    baseUnitBn: '৫০ টি',
    weightOptions: const [
      WeightOption(labelEn: '50 pcs Pack', labelBn: '৫০ টি প্যাক', multiplier: 1.0, unitCode: 'pcs'),
      WeightOption(labelEn: '100 pcs Bamboo Tokri', labelBn: '১০০ টি বাঁশের খাঁচা', multiplier: 1.95, unitCode: 'pcs'),
      WeightOption(labelEn: '200 pcs Gift Basket', labelBn: '২০০ টি উপহার ঝুড়ি', multiplier: 3.8, unitCode: 'pcs'),
    ],
    stockQuantity: 120,
    rating: 5.0,
    reviewCount: 194,
    descriptionEn:
        'The undisputed king of lychees in the subcontinent. Extremely small pit (seed) with thick, translucent, juicy flesh that explodes with honey-like sweetness. Packaged with fresh litchi leaves in traditional bamboo baskets.',
    descriptionBn:
        'লিচুর সেরা জাত দিনাজপুরের বেদানা। খোসা পাতলা, ভেতরের বীজ বা গুটি অত্যন্ত ছোট এবং মিষ্টি ও রসে ভরপুর। সতেজতা বজায় রাখতে পাতাযুক্ত খাঁচায় সরবরাহ করা হয়।',
    storageTipsEn: 'Keep wrapped in damp cloth or refrigerate in ventilated crisper bag. Best enjoyed cold within 48 hours.',
    storageTipsBn: 'হালকা ভেজা সুতি কাপড়ে পেঁচিয়ে বা ফ্রিজের ক্রিস্পারে রাখুন। ৪৮ ঘণ্টার মধ্যে খাওয়া ভালো।',
    harvestTimeEn: 'Handpicked today 5:00 AM',
    harvestTimeBn: 'আজ ভোর ৫টায় হাত দিয়ে বাছাইকৃত',
    seasonalMonths: [5, 6], // May - June
    isInSeason: true,
    isPeakSeason: true,
    qualityGradeEn: 'Royal Select • Micro-Pit',
    qualityGradeBn: 'রয়্যাল সিলেক্ট • ছোট বীজ',
    imageUrl: 'https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?w=800&auto=format&fit=crop&q=80',
  ),

  FruitItem(
    id: 'fruit_haribhanga_03',
    nameEn: 'Rangpur Haribhanga Mango',
    nameBn: 'রংপুরের বিখ্যাত হাড়িভাঙা আম',
    categoryId: 'mangoes',
    varietyEn: 'Haribhanga Organic',
    varietyBn: 'হাড়িভাঙা অর্গানিক',
    originEn: 'Mithapukur, Rangpur',
    originBn: 'মিঠাপুকুর, রংপুর',
    seller: kFarmerAnwar,
    basePriceBDT: 120, // per 1 kg
    baseUnitEn: '1 kg',
    baseUnitBn: '১ কেজি',
    weightOptions: const [
      WeightOption(labelEn: '1 kg Pack', labelBn: '১ কেজি', multiplier: 1.0, unitCode: 'kg'),
      WeightOption(labelEn: '5 kg Eco-Box', labelBn: '৫ কেজি ইকো-বক্স', multiplier: 4.8, unitCode: 'crate'),
      WeightOption(labelEn: '10 kg Carton', labelBn: '১০ কেজি কার্টন', multiplier: 9.4, unitCode: 'crate'),
    ],
    stockQuantity: 620,
    rating: 4.8,
    reviewCount: 220,
    descriptionEn:
        'Rangpur’s pride. Haribhanga is famous for its thick, plump shape, fiberless sweet flesh, and uniquely refreshing aroma. Low sugar index suitable for mindful mango lovers.',
    descriptionBn:
        'উত্তরবঙ্গের গৌরব হাড়িভাঙা আম। এর পুরু রসালো অংশ, মিষ্টি স্বাদ এবং আলাদা সুবাস ভোজনরসিকদের প্রথম পছন্দ। কৃত্রিম হরমোন বা কেমিক্যালমুক্ত।',
    storageTipsEn: 'Store in open room atmosphere. Ripe fruit gives in slightly to gentle finger press.',
    storageTipsBn: 'সাধারণ তাপমাত্রায় রাখুন। পাকার পর নরম চাপ সহ্য করবে।',
    harvestTimeEn: 'Harvested 36 hrs ago',
    harvestTimeBn: '৩৬ ঘণ্টা আগে গাছপাকা সংগ্রহ',
    seasonalMonths: [6, 7], // June - July
    isInSeason: true,
    isPeakSeason: true,
    qualityGradeEn: 'Farm Direct Fresh',
    qualityGradeBn: 'ফার্ম ডিরেক্ট ফ্রেশ',
    imageUrl: 'https://images.unsplash.com/photo-1591073113125-e46713c829ed?w=800&auto=format&fit=crop&q=80',
  ),

  FruitItem(
    id: 'fruit_honey_queen_pineapple_04',
    nameEn: 'Madhupur Honey Queen Pineapple',
    nameBn: 'মধুপুরের মধুসম হানিকুইন আনারস',
    categoryId: 'pineapples',
    varietyEn: 'Honey Queen Red-Soil',
    varietyBn: 'হানিকুইন লালমাটি',
    originEn: 'Madhupur Garh, Tangail',
    originBn: 'মধুপুর গড়, টাঙ্গাইল',
    seller: kFarmerPranesh,
    basePriceBDT: 65, // per piece
    baseUnitEn: '1 piece',
    baseUnitBn: '১ টি',
    weightOptions: const [
      WeightOption(labelEn: '1 piece (Approx 1.2 kg)', labelBn: '১ টি (প্রায় ১.২ কেজি)', multiplier: 1.0, unitCode: 'pcs'),
      WeightOption(labelEn: '3 pcs Family Bundle', labelBn: '৩ টি ফ্যামিলি বান্ডেল', multiplier: 2.85, unitCode: 'pcs'),
      WeightOption(labelEn: '6 pcs Gift Crate', labelBn: '৬ টি গিফট ক্রেট', multiplier: 5.5, unitCode: 'crate'),
    ],
    stockQuantity: 280,
    rating: 4.9,
    reviewCount: 167,
    descriptionEn:
        'Cultivated in the mineral-rich red hill tracts of Madhupur Garh. Exceptionally high brix sweetness with minimal acidity and a vibrant golden core.',
    descriptionBn:
        'মধুপুরের ঐতিহ্যবাহী লাল মাটির মিষ্টি আনারস। ভেতরটা গাঢ় সোনালী, অম্লতাহীন মিষ্টি এবং সুমিষ্ট গন্ধে ভরপুর। কোনো ক্ষতিকর স্প্রে ছাড়া ফলানো।',
    storageTipsEn: 'Store upside down for 1 day before slicing to distribute sugar sweetness evenly throughout the fruit.',
    storageTipsBn: 'কাটার আগে ১ দিন উল্টো করে রাখলে মিষ্টি রস পুরো আনারসে সমানভাবে ছড়িয়ে পড়ে।',
    harvestTimeEn: 'Harvested yesterday afternoon',
    harvestTimeBn: 'গতকাল বিকেলে বাগান থেকে সংগ্রহ',
    seasonalMonths: [5, 6, 7, 8, 9], // May - Sept
    isInSeason: true,
    isPeakSeason: false,
    qualityGradeEn: 'Brix 16+ Extra Sweet',
    qualityGradeBn: 'ব্রিক্স ১৬+ অতিরিক্ত মিষ্টি',
    imageUrl: 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=800&auto=format&fit=crop&q=80',
  ),

  FruitItem(
    id: 'fruit_barisal_guava_05',
    nameEn: 'Swarupkathi Crisp Thai Guava',
    nameBn: 'স্বরূপকাঠির মচমচে থাই পেয়ারা',
    categoryId: 'guavas',
    varietyEn: 'Thai Super-7',
    varietyBn: 'থাই সুপার-৭',
    originEn: 'Atghar Kuriana, Barisal',
    originBn: 'আটঘর কুড়িয়ানা, বরিশাল',
    seller: kFarmerZakir,
    basePriceBDT: 90, // per 1 kg
    baseUnitEn: '1 kg',
    baseUnitBn: '১ কেজি',
    weightOptions: const [
      WeightOption(labelEn: '1 kg (3-4 pcs)', labelBn: '১ কেজি (৩-৪ টি)', multiplier: 1.0, unitCode: 'kg'),
      WeightOption(labelEn: '2 kg Value Pack', labelBn: '২ কেজি ভ্যালু প্যাক', multiplier: 1.95, unitCode: 'kg'),
      WeightOption(labelEn: '5 kg Wholesale Box', labelBn: '৫ কেজি হোলসেল বক্স', multiplier: 4.7, unitCode: 'crate'),
    ],
    stockQuantity: 340,
    rating: 4.7,
    reviewCount: 95,
    descriptionEn:
        'Grown in the river basin soils of Barisal’s famous floating orchards. Crispy texture, sweet aroma, rich in natural Vitamin C.',
    descriptionBn:
        'বরিশালের বিখ্যাত ভাসমান পেয়ারা অঞ্চলের মিষ্টি থাই পেয়ারা। চমৎকার মচমচে ও সুস্বাদু, প্রচুর ভিটামিন সি সমৃদ্ধ।',
    storageTipsEn: 'Store in refrigerator crisper for up to 7 days of crisp crunch.',
    storageTipsBn: 'ফ্রিজের নিচের অংশে রাখলে ৭ দিন পর্যন্ত মচমচে থাকে।',
    harvestTimeEn: 'Fresh morning harvest',
    harvestTimeBn: 'আজ সকালে তোলা',
    seasonalMonths: [7, 8, 9, 10], // July - Oct
    isInSeason: true,
    isPeakSeason: true,
    qualityGradeEn: 'A-Grade Crisp Select',
    qualityGradeBn: 'এ-গ্রেড ক্রিস্পি সিলেক্ট',
    imageUrl: 'https://images.unsplash.com/photo-1536511135899-73e4492bf35f?w=800&auto=format&fit=crop&q=80',
  ),

  FruitItem(
    id: 'fruit_dragon_jhenaidah_06',
    nameEn: 'Red Velvet Dragon Fruit',
    nameBn: 'ঝিনাইদহের গাঢ় লাল ড্রাগন ফল',
    categoryId: 'dragonfruit',
    varietyEn: 'Ruby Red Velvet',
    varietyBn: 'রুবি রেড ভেলভেট',
    originEn: 'Maheshpur, Jhenaidah',
    originBn: 'মহেশপুর, ঝিনাইদহ',
    seller: kFarmerZakir,
    basePriceBDT: 260, // per 1 kg
    baseUnitEn: '1 kg',
    baseUnitBn: '১ কেজি',
    weightOptions: const [
      WeightOption(labelEn: '1 kg (2-3 large pcs)', labelBn: '১ কেজি (২-৩ টি বড়)', multiplier: 1.0, unitCode: 'kg'),
      WeightOption(labelEn: '3 kg Family Pack', labelBn: '৩ কেজি ফ্যামিলি প্যাক', multiplier: 2.9, unitCode: 'kg'),
    ],
    stockQuantity: 190,
    rating: 4.8,
    reviewCount: 112,
    descriptionEn:
        'Intense antioxidant-rich deep magenta flesh with mild refreshing sweetness. Organically cultivated without chemical boosters.',
    descriptionBn:
        'গাঢ় লাল রঙের রসালো ও মিষ্টি ড্রাগন ফল। রক্তস্বল্পতা ও রোগ প্রতিরোধে অত্যন্ত কার্যকরী। প্রাকৃতিক উপায়ে উৎপাদিত।',
    storageTipsEn: 'Refrigerate. Tastes delightful when chilled and sliced.',
    storageTipsBn: 'ঠাণ্ডা করে খেলে স্বাদ দ্বিগুণ অনুভূত হয়।',
    harvestTimeEn: 'Harvested 2 days ago',
    harvestTimeBn: '২ দিন আগে বাগান থেকে নামানো',
    seasonalMonths: [6, 7, 8, 9, 10, 11],
    isInSeason: true,
    isPeakSeason: false,
    qualityGradeEn: 'Organic Certified Farm',
    qualityGradeBn: 'সার্টিফাইড অর্গানিক ফার্ম',
    imageUrl: 'https://images.unsplash.com/photo-1527325678964-54921661f888?w=800&auto=format&fit=crop&q=80',
  ),

  FruitItem(
    id: 'fruit_amrapali_07',
    nameEn: 'Meherpur Premium Amrapali',
    nameBn: 'মেহেরপুরের মিষ্টি আম্রপালি আম',
    categoryId: 'mangoes',
    varietyEn: 'Amrapali Select',
    varietyBn: 'আম্রপালি সিলেক্ট',
    originEn: 'Mujibnagar, Meherpur',
    originBn: 'মুজিবনগর, মেহেরপুর',
    seller: kFarmerFazlur,
    basePriceBDT: 130, // per 1 kg
    baseUnitEn: '1 kg',
    baseUnitBn: '১ কেজি',
    weightOptions: const [
      WeightOption(labelEn: '1 kg Pack', labelBn: '১ কেজি', multiplier: 1.0, unitCode: 'kg'),
      WeightOption(labelEn: '5 kg Eco-Box', labelBn: '৫ কেজি ইকো-বক্স', multiplier: 4.8, unitCode: 'crate'),
      WeightOption(labelEn: '10 kg Master Crate', labelBn: '১০ কেজি মাস্টার ক্রেট', multiplier: 9.3, unitCode: 'crate'),
    ],
    stockQuantity: 520,
    rating: 4.9,
    reviewCount: 280,
    descriptionEn:
        'Deep red-orange flesh with incomparable sweetness. Amrapali is celebrated for its rich pulp-to-stone ratio and honey flavor.',
    descriptionBn:
        'গাঢ় কমলা রঙের রসালো ও মনমাতানো মিষ্টি আম্রপালি। ছোট আঁটি ও ঘন শাঁসের জন্য সবার অত্যন্ত পছন্দের।',
    storageTipsEn: 'Store in cool ventilated room.',
    storageTipsBn: 'শীতল ও বাতাস চলাচল করে এমন স্থানে রাখুন।',
    harvestTimeEn: 'Harvested yesterday',
    harvestTimeBn: 'গতকাল সকালে গাছ থেকে পাড়া',
    seasonalMonths: [6, 7, 8], // June - August
    isInSeason: true,
    isPeakSeason: true,
    qualityGradeEn: 'A+ Export Grade',
    qualityGradeBn: 'এ+ এক্সপোর্ট গ্রেড',
    imageUrl: 'https://images.unsplash.com/photo-1591073113125-e46713c829ed?w=800&auto=format&fit=crop&q=80',
  ),

  FruitItem(
    id: 'bundle_madhumash_trio_08',
    nameEn: 'Madhumash Special Celebration Crate',
    nameBn: 'মধুমাস স্পেশাল ফ্রুট ক্রেইট',
    categoryId: 'bundles',
    varietyEn: 'Seasonal Harvest Trio (Mango + Lychee + Pineapple)',
    varietyBn: 'মৌসুমি সেরা ত্রয়ী (হিমসাগর + বেদানা লিচু + আনারস)',
    originEn: 'Multi-Orchard Partner Express',
    originBn: 'যৌথ বাগান সরাসরি এক্সপ্রেস',
    seller: kFarmerFazlur,
    basePriceBDT: 1150, // per bundle
    baseUnitEn: '1 Luxury Crate',
    baseUnitBn: '১ টি স্পেশাল বক্স',
    weightOptions: const [
      WeightOption(labelEn: 'Standard Crate (3kg Himsagar + 50pcs Lychee + 1 Pineapple)', labelBn: 'স্ট্যান্ডার্ড বক্স (৩কেজি হিমসাগর + ৫০টি লিচু + ১টি আনারস)', multiplier: 1.0, unitCode: 'crate'),
      WeightOption(labelEn: 'Grand Family Crate (5kg Himsagar + 100pcs Lychee + 2 Pineapples)', labelBn: 'গ্র্যান্ড বক্স (৫কেজি হিমসাগর + ১০০টি লিচু + ২টি আনারস)', multiplier: 1.85, unitCode: 'crate'),
    ],
    stockQuantity: 65,
    rating: 5.0,
    reviewCount: 88,
    descriptionEn:
        'The ultimate taste of Bangladeshi summer! Packed in a handcrafted biodegradable bamboo wooden crate with greeting note. Perfect for family gifts and special celebrations.',
    descriptionBn:
        'বাঙালি মধুমাসের রাজকীয় উপহার! প্রিমিয়াম জাতের চাঁপাই হিমসাগর, দিনাজপুরের বেদানা লিচু এবং মধুপুরের মিষ্টি আনারসের বিশেষ সংকলন। উপহারের জন্য সেরা।',
    storageTipsEn: 'Individual fruit storage guidelines included inside the gift crate note.',
    storageTipsBn: 'বক্সের ভেতরের কার্ডে প্রতিটি ফলের সঠিক সংরক্ষণ নিয়ম উল্লেখ আছে।',
    harvestTimeEn: 'Freshly assembled today',
    harvestTimeBn: 'আজ সকালে বিশেষ যত্নে প্রস্তুতকৃত',
    seasonalMonths: [5, 6], // Peak Madhumash
    isInSeason: true,
    isPeakSeason: true,
    isFeaturedBundle: true,
    qualityGradeEn: 'Royal Reserve VIP Pack',
    qualityGradeBn: 'রয়েল রিজার্ভ ভিআইপি প্যাক',
    imageUrl: 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=800&auto=format&fit=crop&q=80',
  ),
];
