import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item.dart';
import '../../../core/models/fruit_item.dart';

class CartState {
  final List<CartItem> items;
  final String? appliedCoupon;
  final double discountPercent;
  final int flatDiscountBDT;

  const CartState({
    this.items = const [],
    this.appliedCoupon,
    this.discountPercent = 0.0,
    this.flatDiscountBDT = 0,
  });

  int get subtotalBDT {
    int sum = 0;
    for (final item in items) {
      sum += item.totalPriceBDT;
    }
    return sum;
  }

  int get totalItemsCount {
    int count = 0;
    for (final item in items) {
      count += item.quantity;
    }
    return count;
  }

  int calculateDiscount() {
    int discount = 0;
    if (discountPercent > 0) {
      discount += (subtotalBDT * discountPercent).round();
    }
    discount += flatDiscountBDT;
    if (discount > subtotalBDT) {
      return subtotalBDT;
    }
    return discount;
  }

  int calculateTotal(int deliveryFeeBDT) {
    if (items.isEmpty) return 0;
    return subtotalBDT - calculateDiscount() + deliveryFeeBDT;
  }

  CartState copyWith({
    List<CartItem>? items,
    String? appliedCoupon,
    bool clearCoupon = false,
    double? discountPercent,
    int? flatDiscountBDT,
  }) {
    return CartState(
      items: items ?? this.items,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      discountPercent: clearCoupon ? 0.0 : (discountPercent ?? this.discountPercent),
      flatDiscountBDT: clearCoupon ? 0 : (flatDiscountBDT ?? this.flatDiscountBDT),
    );
  }
}

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    return const CartState();
  }

  void addToCart(FruitItem fruit, WeightOption weight, {int quantity = 1}) {
    final existingIndex = state.items.indexWhere(
      (item) => item.fruit.id == fruit.id && item.selectedWeight.labelEn == weight.labelEn,
    );

    if (existingIndex >= 0) {
      final updatedList = List<CartItem>.from(state.items);
      final currentItem = updatedList[existingIndex];
      updatedList[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + quantity,
      );
      state = state.copyWith(items: updatedList);
    } else {
      final newItem = CartItem(
        fruit: fruit,
        selectedWeight: weight,
        quantity: quantity,
      );
      state = state.copyWith(items: [...state.items, newItem]);
    }
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(item);
      return;
    }

    final index = state.items.indexOf(item);
    if (index >= 0) {
      final updatedList = List<CartItem>.from(state.items);
      updatedList[index] = item.copyWith(quantity: newQuantity);
      state = state.copyWith(items: updatedList);
    }
  }

  void removeItem(CartItem item) {
    state = state.copyWith(
      items: state.items.where((i) => i != item).toList(),
    );
  }

  bool applyCoupon(String code) {
    final clean = code.trim().toUpperCase();
    if (clean == 'PROTHOM' || clean == 'FRUIT10') {
      state = state.copyWith(
        appliedCoupon: clean,
        discountPercent: 0.10, // 10% discount
        flatDiscountBDT: 0,
      );
      return true;
    } else if (clean == 'MADHUMASH' || clean == 'MANGO15') {
      state = state.copyWith(
        appliedCoupon: clean,
        discountPercent: 0.15, // 15% festival discount
        flatDiscountBDT: 0,
      );
      return true;
    } else if (clean == 'BDT50') {
      state = state.copyWith(
        appliedCoupon: clean,
        discountPercent: 0.0,
        flatDiscountBDT: 50,
      );
      return true;
    }
    return false;
  }

  void removeCoupon() {
    state = state.copyWith(clearCoupon: true);
  }

  void clearCart() {
    state = const CartState();
  }
}

final cartProvider = NotifierProvider<CartNotifier, CartState>(() {
  return CartNotifier();
});
