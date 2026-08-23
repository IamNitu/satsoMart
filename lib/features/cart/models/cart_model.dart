import 'package:sasto_mart/features/home/models/product_model.dart';

class CartModel {
  final Product product;
  final int quantity;

  const CartModel({
    required this.product,
    this.quantity =1
  });

  double get unitPrice => product.discountPrice ?? product.price;

  double get totalPrice => unitPrice * quantity;

  double get totalSavings{
    if(product.discountPrice !=null && product.price > product.discountPrice!){
      return (product.price - product.discountPrice!) *quantity;
    }
    return 0.0;
  }

  CartModel copyWith({
    Product? product,
    int? quantity,
  }){
    return CartModel(
      product: product ?? this.product,
      quantity: quantity ??  this.quantity);
  }
}