import 'cart_item.dart';
import '../localization/location_provider.dart';

enum OrderStatus {
  pendingConfirmation,
  confirmed,
  packed,
  outForDelivery,
  delivered,
  cancelled,
}

enum PaymentMethod {
  cashOnDelivery,
  bkash,
  nagad,
}

class OrderModel {
  final String orderId;
  final List<CartItem> items;
  final DeliveryLocation location;
  final String specificAddress;
  final String contactPhone;
  final PaymentMethod paymentMethod;
  final OrderStatus status;
  final int subtotalBDT;
  final int deliveryFeeBDT;
  final int discountBDT;
  final int totalBDT;
  final DateTime createdAt;
  final String? promoCode;

  const OrderModel({
    required this.orderId,
    required this.items,
    required this.location,
    required this.specificAddress,
    required this.contactPhone,
    required this.paymentMethod,
    required this.status,
    required this.subtotalBDT,
    required this.deliveryFeeBDT,
    required this.discountBDT,
    required this.totalBDT,
    required this.createdAt,
    this.promoCode,
  });

  String getStatusDisplay(String lang) {
    switch (status) {
      case OrderStatus.pendingConfirmation:
        return lang == 'bn' ? 'অর্ডার গ্রহণ করা হয়েছে' : 'Order Received';
      case OrderStatus.confirmed:
        return lang == 'bn' ? 'বাগান থেকে বুকিং নিশ্চিত' : 'Confirmed with Orchard';
      case OrderStatus.packed:
        return lang == 'bn' ? 'পরিবেশবান্ধব ক্রেটে প্যাক করা হয়েছে' : 'Packed in Fresh Crate';
      case OrderStatus.outForDelivery:
        return lang == 'bn' ? 'তাজা ডেলিভারির পথে' : 'Out for Delivery';
      case OrderStatus.delivered:
        return lang == 'bn' ? 'ডেলিভারি সম্পন্ন' : 'Delivered Fresh';
      case OrderStatus.cancelled:
        return lang == 'bn' ? 'অর্ডার বাতিল' : 'Cancelled';
    }
  }

  String getPaymentDisplay(String lang) {
    switch (paymentMethod) {
      case PaymentMethod.cashOnDelivery:
        return lang == 'bn' ? 'ক্যাশ অন ডেলিভারি (Cash on Delivery)' : 'Cash on Delivery (COD)';
      case PaymentMethod.bkash:
        return lang == 'bn' ? 'বিকাশ (bKash Mobile Banking)' : 'bKash Digital Payment';
      case PaymentMethod.nagad:
        return lang == 'bn' ? 'নগদ (Nagad Mobile Banking)' : 'Nagad Digital Payment';
    }
  }
}
