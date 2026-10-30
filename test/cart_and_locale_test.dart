import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitbari/core/data/mock_fruit_data.dart';
import 'package:fruitbari/core/localization/locale_provider.dart';
import 'package:fruitbari/core/localization/location_provider.dart';
import 'package:fruitbari/core/models/order.dart';
import 'package:fruitbari/core/models/user_model.dart';
import 'package:fruitbari/features/auth/controller/auth_controller.dart';
import 'package:fruitbari/features/cart/controller/cart_controller.dart';
import 'package:fruitbari/features/orders/controller/orders_controller.dart';

void main() {
  group('FruitBari Core Architecture Tests', () {
    test('LocaleNotifier toggles correctly between English and Bangla', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(localeProvider), 'en');
      container.read(localeProvider.notifier).toggleLocale();
      expect(container.read(localeProvider), 'bn');
      container.read(localeProvider.notifier).toggleLocale();
      expect(container.read(localeProvider), 'en');
    });

    test('CartNotifier handles items, weight options, and line totals', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final fruit = kMockFruits.first; // Himsagar mango base price 140
      final weightOption = fruit.weightOptions[0]; // 1 kg multiplier 1.0

      container.read(cartProvider.notifier).addToCart(fruit, weightOption, quantity: 2);

      final state = container.read(cartProvider);
      expect(state.items.length, 1);
      expect(state.items.first.quantity, 2);
      expect(state.subtotalBDT, 280); // 140 * 1.0 * 2 = 280
    });

    test('CartNotifier applies PROTHOM 10% coupon correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final fruit = kMockFruits.first; // base price 140
      final weightOption = fruit.weightOptions[0];

      container.read(cartProvider.notifier).addToCart(fruit, weightOption, quantity: 10); // 1400 BDT
      expect(container.read(cartProvider).subtotalBDT, 1400);

      final applied = container.read(cartProvider.notifier).applyCoupon('PROTHOM');
      expect(applied, true);

      final state = container.read(cartProvider);
      expect(state.calculateDiscount(), 140); // 10% of 1400
      expect(state.calculateTotal(60), 1320); // 1400 - 140 + 60 delivery fee
    });

    test('OrdersNotifier places order and tracks lifecycle', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final fruit = kMockFruits.first;
      final location = kSupportedLocations.first;

      container.read(cartProvider.notifier).addToCart(fruit, fruit.weightOptions.first);
      final cart = container.read(cartProvider);

      final order = container.read(ordersProvider.notifier).placeOrder(
            items: cart.items,
            location: location,
            address: 'Road 5, House 12, Gulshan 2',
            phone: '01711223344',
            paymentMethod: PaymentMethod.cashOnDelivery,
            subtotalBDT: cart.subtotalBDT,
            deliveryFeeBDT: location.deliveryFeeBDT,
            discountBDT: 0,
            totalBDT: cart.subtotalBDT + location.deliveryFeeBDT,
          );

      expect(order.orderId.startsWith('FB-'), true);
      expect(order.status, OrderStatus.confirmed);
      expect(container.read(ordersProvider).length, 1);
    });

    test('Bangladesh seasonal fruit matrix has verified data', () {
      expect(kMockFruits.isNotEmpty, true);
      final himsagar = kMockFruits.firstWhere((f) => f.id == 'fruit_himsagar_01');
      expect(himsagar.originEn.contains('Chapainawabganj'), true);
      expect(himsagar.seasonalMonths.contains(6), true); // June is peak season
      expect(himsagar.seller.isVerifiedFarmer, true);
    });

    test('Admin authentication strictly validates authorized credentials and rejects unauthorized logins', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Attempt unauthorized admin login
      final failedLogin = await container.read(authProvider.notifier).loginAdmin(
            email: 'fake_admin@fruitbari.com',
            password: 'wrong_password',
          );
      expect(failedLogin, false);
      expect(container.read(authProvider).isAdmin, false);
      expect(container.read(authProvider).authError, contains('Access Denied'));

      // Legitimate authorized admin login
      final successfulLogin = await container.read(authProvider.notifier).loginAdmin(
            email: kAuthorizedAdminEmail,
            password: kAuthorizedAdminPassword,
          );
      expect(successfulLogin, true);
      expect(container.read(authProvider).isAdmin, true);
      expect(container.read(authProvider).currentUser?.emailOrPhone, kAuthorizedAdminEmail);
    });

    test('Seller registration starts with pending approval and requires admin verification', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Register new seller
      final registered = await container.read(authProvider.notifier).registerSeller(
            name: 'Rashidul Islam',
            shopName: 'Rajshahi Amrapali Bagan',
            emailOrPhone: 'rashid@fruitbari.com',
            shopLocation: 'Paba, Rajshahi',
            password: 'secretpassword',
          );

      expect(registered, true);
      final currentSeller = container.read(authProvider).currentUser!;
      expect(currentSeller.isSeller, true);
      expect(currentSeller.sellerStatus, SellerApprovalStatus.pending);
      expect(currentSeller.isSellerApproved, false);

      // Admin approves the seller
      container.read(authProvider.notifier).approveSeller(currentSeller.id);
      final approvedUser = container.read(authProvider).currentUser!;
      expect(approvedUser.sellerStatus, SellerApprovalStatus.approved);
      expect(approvedUser.isSellerApproved, true);
    });

    test('Customer can update basic profile info without sensitive changes', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initial = container.read(authProvider).currentUser!;
      expect(initial.isCustomer, true);

      container.read(authProvider.notifier).updateCustomerProfile(
            name: 'Tanvir Hossain Chowdhury',
            avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
            deliveryAddress: 'Flat 5B, Road 27, Banani',
            district: 'Gulshan & Banani, Dhaka',
          );

      final updated = container.read(authProvider).currentUser!;
      expect(updated.name, 'Tanvir Hossain Chowdhury');
      expect(updated.deliveryAddress, 'Flat 5B, Road 27, Banani');
      expect(updated.avatarUrl, contains('photo-1507003211169-0a1dd7228f2d'));
    });
  });
}
