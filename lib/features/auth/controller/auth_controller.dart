import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';

// Pre-defined Authorized Administrator Credentials
const String kAuthorizedAdminEmail = 'admin@fruitbari.com';
const String kAuthorizedAdminPassword = 'FruitBari#Admin2026';

class AuthState {
  final UserModel? currentUser;
  final List<UserModel> registeredSellers; // Maintains seller accounts for review & persistence
  final String? authError;
  final bool isLoading;

  const AuthState({
    this.currentUser,
    this.registeredSellers = const [],
    this.authError,
    this.isLoading = false,
  });

  bool get isAuthenticated => currentUser != null;
  bool get isAdmin => currentUser?.role == UserRole.admin;
  bool get isSeller => currentUser?.role == UserRole.seller;
  bool get isCustomer => currentUser?.role == UserRole.customer;

  AuthState copyWith({
    UserModel? currentUser,
    bool clearUser = false,
    List<UserModel>? registeredSellers,
    String? authError,
    bool clearError = false,
    bool? isLoading,
  }) {
    return AuthState(
      currentUser: clearUser ? null : (currentUser ?? this.currentUser),
      registeredSellers: registeredSellers ?? this.registeredSellers,
      authError: clearError ? null : (authError ?? this.authError),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Initial approved seller (Fazlur Rahman) and a sample pending seller
    final initialSellers = [
      const UserModel(
        id: 'seller_01',
        name: 'Haji Fazlur Rahman',
        emailOrPhone: 'fazlur@fruitbari.com',
        role: UserRole.seller,
        shopName: 'Rohanpur Mango Heritage Orchard',
        shopLocation: 'Rohanpur, Chapainawabganj',
        avatarUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=200&auto=format&fit=crop&q=80',
        sellerStatus: SellerApprovalStatus.approved,
      ),
      const UserModel(
        id: 'seller_02',
        name: 'Mizanur Rahman',
        emailOrPhone: 'mizan@fruitbari.com',
        role: UserRole.seller,
        shopName: 'Barendra Organic Jackfruit & Litchi',
        shopLocation: 'Belabo, Narsingdi',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
        sellerStatus: SellerApprovalStatus.pending,
      ),
    ];

    // Default active customer for smooth preview
    const defaultCustomer = UserModel(
      id: 'cust_01',
      name: 'Tanvir Ahmed',
      emailOrPhone: '01711-223344',
      role: UserRole.customer,
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
      deliveryAddress: 'House 14, Road 11, Block D',
      district: 'Gulshan & Banani, Dhaka',
    );

    return AuthState(
      currentUser: defaultCustomer,
      registeredSellers: initialSellers,
    );
  }

  /// Secure Administrator Login - Only accepts authorized admin account
  Future<bool> loginAdmin({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future.delayed(const Duration(milliseconds: 400));

    final cleanEmail = email.trim().toLowerCase();
    final cleanPass = password.trim();

    if (cleanEmail == kAuthorizedAdminEmail && cleanPass == kAuthorizedAdminPassword) {
      const adminUser = UserModel(
        id: 'admin_root',
        name: 'FruitBari Platform Admin',
        emailOrPhone: kAuthorizedAdminEmail,
        role: UserRole.admin,
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&auto=format&fit=crop&q=80',
        district: 'Dhaka Headquarters',
      );
      state = state.copyWith(currentUser: adminUser, isLoading: false);
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        authError: 'Access Denied: Invalid administrator credentials. Only authorized platform accounts may access this portal.',
      );
      return false;
    }
  }

  /// Customer Sign In
  Future<bool> loginCustomer({
    required String emailOrPhone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future.delayed(const Duration(milliseconds: 300));

    if (emailOrPhone.trim().isEmpty || password.trim().isEmpty) {
      state = state.copyWith(isLoading: false, authError: 'Please enter mobile number/email and password');
      return false;
    }

    final customer = UserModel(
      id: 'cust_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      name: emailOrPhone.contains('@') ? emailOrPhone.split('@').first : 'Valued Customer',
      emailOrPhone: emailOrPhone.trim(),
      role: UserRole.customer,
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
      deliveryAddress: 'House 14, Road 11, Block D',
      district: 'Gulshan & Banani, Dhaka',
    );

    state = state.copyWith(currentUser: customer, isLoading: false);
    return true;
  }

  /// Customer Registration
  Future<bool> registerCustomer({
    required String name,
    required String emailOrPhone,
    required String password,
    required String deliveryAddress,
    required String district,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future.delayed(const Duration(milliseconds: 350));

    final newCustomer = UserModel(
      id: 'cust_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      name: name.trim(),
      emailOrPhone: emailOrPhone.trim(),
      role: UserRole.customer,
      deliveryAddress: deliveryAddress.trim(),
      district: district.trim(),
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
    );

    state = state.copyWith(currentUser: newCustomer, isLoading: false);
    return true;
  }

  /// Customer Basic Profile Edit (Name, Avatar, Delivery Address, District) - Nothing sensitive
  void updateCustomerProfile({
    required String name,
    required String? avatarUrl,
    required String deliveryAddress,
    required String district,
  }) {
    if (state.currentUser == null) return;

    final updated = state.currentUser!.copyWith(
      name: name.trim(),
      avatarUrl: avatarUrl,
      deliveryAddress: deliveryAddress.trim(),
      district: district.trim(),
    );

    state = state.copyWith(currentUser: updated);
  }

  /// Seller Registration - Starts in 'pending' status
  Future<bool> registerSeller({
    required String name,
    required String shopName,
    required String emailOrPhone,
    required String password,
    required String shopLocation,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future.delayed(const Duration(milliseconds: 400));

    final newSeller = UserModel(
      id: 'seller_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      name: name.trim(),
      emailOrPhone: emailOrPhone.trim(),
      shopName: shopName.trim(),
      shopLocation: shopLocation.trim(),
      role: UserRole.seller,
      sellerStatus: SellerApprovalStatus.pending, // Pending Admin review!
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
    );

    final updatedList = [...state.registeredSellers, newSeller];
    state = state.copyWith(
      currentUser: newSeller,
      registeredSellers: updatedList,
      isLoading: false,
    );
    return true;
  }

  /// Seller Sign In
  Future<bool> loginSeller({
    required String emailOrPhone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future.delayed(const Duration(milliseconds: 350));

    final cleanContact = emailOrPhone.trim().toLowerCase();

    // Check existing registered sellers
    final existing = state.registeredSellers.cast<UserModel?>().firstWhere(
          (s) => s!.emailOrPhone.toLowerCase() == cleanContact,
          orElse: () => null,
        );

    if (existing != null) {
      state = state.copyWith(currentUser: existing, isLoading: false);
      return true;
    }

    // If new login credentials for demonstration
    final demoSeller = UserModel(
      id: 'seller_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      name: cleanContact.contains('@') ? cleanContact.split('@').first : 'Registered Farmer',
      emailOrPhone: cleanContact,
      shopName: 'Green Orchard & Farm',
      shopLocation: 'Rajshahi Sadar',
      role: UserRole.seller,
      sellerStatus: SellerApprovalStatus.approved,
      avatarUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=200&auto=format&fit=crop&q=80',
    );

    state = state.copyWith(
      currentUser: demoSeller,
      registeredSellers: [...state.registeredSellers, demoSeller],
      isLoading: false,
    );
    return true;
  }

  /// Admin Action: Approve Seller Application
  void approveSeller(String sellerId) {
    final updatedList = state.registeredSellers.map((s) {
      if (s.id == sellerId) {
        return s.copyWith(sellerStatus: SellerApprovalStatus.approved);
      }
      return s;
    }).toList();

    UserModel? updatedCurrent = state.currentUser;
    if (state.currentUser?.id == sellerId) {
      updatedCurrent = state.currentUser?.copyWith(sellerStatus: SellerApprovalStatus.approved);
    }

    state = state.copyWith(
      registeredSellers: updatedList,
      currentUser: updatedCurrent,
    );
  }

  /// Admin Action: Reject Seller Application
  void rejectSeller(String sellerId) {
    final updatedList = state.registeredSellers.map((s) {
      if (s.id == sellerId) {
        return s.copyWith(sellerStatus: SellerApprovalStatus.rejected);
      }
      return s;
    }).toList();

    UserModel? updatedCurrent = state.currentUser;
    if (state.currentUser?.id == sellerId) {
      updatedCurrent = state.currentUser?.copyWith(sellerStatus: SellerApprovalStatus.rejected);
    }

    state = state.copyWith(
      registeredSellers: updatedList,
      currentUser: updatedCurrent,
    );
  }

  /// Sign out
  void logout() {
    state = state.copyWith(clearUser: true, clearError: true);
  }

  /// Quick switch to predefined demo roles for testing convenience
  void switchToDemoRole(UserRole role) {
    if (role == UserRole.admin) {
      loginAdmin(email: kAuthorizedAdminEmail, password: kAuthorizedAdminPassword);
    } else if (role == UserRole.seller) {
      state = state.copyWith(currentUser: state.registeredSellers.first);
    } else {
      loginCustomer(emailOrPhone: '01711-223344', password: 'password123');
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
