import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item.dart';
import '../../../core/models/order.dart';
import '../../../core/localization/location_provider.dart';

class OrdersNotifier extends Notifier<List<OrderModel>> {
  @override
  List<OrderModel> build() {
    return [];
  }

  OrderModel placeOrder({
    required List<CartItem> items,
    required DeliveryLocation location,
    required String address,
    required String phone,
    required PaymentMethod paymentMethod,
    required int subtotalBDT,
    required int deliveryFeeBDT,
    required int discountBDT,
    required int totalBDT,
    String? promoCode,
  }) {
    final orderId = 'FB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final newOrder = OrderModel(
      orderId: orderId,
      items: List.from(items),
      location: location,
      specificAddress: address,
      contactPhone: phone,
      paymentMethod: paymentMethod,
      status: OrderStatus.confirmed, // Initial confirmed state with farmer
      subtotalBDT: subtotalBDT,
      deliveryFeeBDT: deliveryFeeBDT,
      discountBDT: discountBDT,
      totalBDT: totalBDT,
      createdAt: DateTime.now(),
      promoCode: promoCode,
    );

    state = [newOrder, ...state];
    return newOrder;
  }

  OrderModel? getOrderById(String orderId) {
    try {
      return state.firstWhere((o) => o.orderId == orderId);
    } catch (_) {
      return null;
    }
  }
}

final ordersProvider = NotifierProvider<OrdersNotifier, List<OrderModel>>(() {
  return OrdersNotifier();
});
