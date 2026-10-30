enum UserRole {
  customer,
  seller,
  admin,
}

enum SellerApprovalStatus {
  pending,
  approved,
  rejected,
}

class UserModel {
  final String id;
  final String name;
  final String emailOrPhone;
  final UserRole role;
  final String? avatarUrl;
  final String? deliveryAddress;
  final String? district;

  // Seller specific attributes
  final String? shopName;
  final String? shopLocation;
  final SellerApprovalStatus sellerStatus;

  const UserModel({
    required this.id,
    required this.name,
    required this.emailOrPhone,
    required this.role,
    this.avatarUrl,
    this.deliveryAddress,
    this.district,
    this.shopName,
    this.shopLocation,
    this.sellerStatus = SellerApprovalStatus.approved,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isSeller => role == UserRole.seller;
  bool get isCustomer => role == UserRole.customer;
  bool get isSellerApproved => isSeller && sellerStatus == SellerApprovalStatus.approved;

  UserModel copyWith({
    String? id,
    String? name,
    String? emailOrPhone,
    UserRole? role,
    String? avatarUrl,
    String? deliveryAddress,
    String? district,
    String? shopName,
    String? shopLocation,
    SellerApprovalStatus? sellerStatus,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      district: district ?? this.district,
      shopName: shopName ?? this.shopName,
      shopLocation: shopLocation ?? this.shopLocation,
      sellerStatus: sellerStatus ?? this.sellerStatus,
    );
  }
}
