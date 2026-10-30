import 'fruit_item.dart';

class CartItem {
  final FruitItem fruit;
  final WeightOption selectedWeight;
  final int quantity; // Number of units of this weight option

  const CartItem({
    required this.fruit,
    required this.selectedWeight,
    required this.quantity,
  });

  int get unitPriceBDT => fruit.calculatePrice(selectedWeight);
  int get totalPriceBDT => unitPriceBDT * quantity;

  CartItem copyWith({
    FruitItem? fruit,
    WeightOption? selectedWeight,
    int? quantity,
  }) {
    return CartItem(
      fruit: fruit ?? this.fruit,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      quantity: quantity ?? this.quantity,
    );
  }
}
