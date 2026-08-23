// Event
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/features/cart/models/cart_model.dart';
import 'package:sasto_mart/features/home/models/product_model.dart';

abstract class CartEvent extends Equatable{
   const CartEvent();

   @override
   List<Object?> get props => [];
}

class AddToCart extends CartEvent{
  final Product product;
  final int quantity;

  const AddToCart( this.product , {this.quantity =1});

  @override
  List<Object?> get props =>[product, quantity];
}
 
class RemoveFromCart extends CartEvent{
  final Product productId;

  const RemoveFromCart( this.productId);

  @override
  List<Object?> get props =>[productId];
}
 
class UpdateCartQuantity extends CartEvent{
  final String productId;
  final int quantity;

  const UpdateCartQuantity( this.productId, {this.quantity=1});

  @override
  List<Object?> get props =>[productId, quantity];
}

class clearCart extends CartEvent{}
 
// state
abstract class CartState extends Equatable{
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState{}

class CartLoaded extends CartState{
  final List<CartModel> items;

  const CartLoaded({this.items =const []});

  int get totalItemCount => items.fold(0, (total,item)=> total +item.quantity);

  double get subtotal => items.fold(0.0, (sum,item)=> sum +item.totalPrice);

  double get totalSavings => items.fold(0.0, (sum,item)=> sum +item.totalSavings);

  double get deliveryFee {
    if(items.isEmpty) return 0.0;
    return subtotal >=50.0 ?0.0 :5.0;
  }

  double get grandTotal => subtotal+deliveryFee;

  bool containsProduct(String productId){
    return items.any((item)=>item.product.id ==productId);
  }

  int getproductQuantity(String productId){
    final item = items.where((i)=>i.product.id == productId);
    return item.isNotEmpty?item.first.quantity :0;
  }

  List<Object?> get props => [items];
}

// bloc
class CartBloc extends Bloc<CartEvent, CartState>{
  CartBloc(): super(const CartLoaded(items: [])){
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_removeFromCart);
    on<UpdateCartQuantity>(_updateCartQuantity);
    on<clearCart>(_clearCart);
  }

  void _onAddToCart(AddToCart event ,Emitter<CartState> emit){
    if(state is! CartLoaded) return;

    final currentItems =List<CartModel>.from((state as CartLoaded).items);

    final existingIndex = currentItems.indexWhere((item)=>item.product.id == event.product.id);

    if(existingIndex >=0 ){
      final existingItem = currentItems[existingIndex];
      final newQuantity = existingItem.quantity + event.quantity;

      final finalQuantity =(event.product.stock > 0 && newQuantity > event.product.stock)
      ? event.product.stock:newQuantity;

      currentItems[existingIndex] = existingItem.copyWith(quantity: finalQuantity);
    }else{
      currentItems.add(CartModel(product: event.product,
      quantity: event.quantity));
    }
  }

  void _removeFromCart(RemoveFromCart event , Emitter<CartState> emit){
    if(state is! CartLoaded) return;

    final currentItems = List<CartModel>.from((state as CartLoaded).items);
    currentItems.removeWhere((item) => item.product.id == event.productId);

    emit(CartLoaded(items: currentItems));
  }

  void _updateCartQuantity(UpdateCartQuantity event , Emitter<CartState> emit){
    if(state is! CartLoaded) return;

    final currentItems = List<CartModel>.from((state as CartLoaded).items);
    final index = currentItems.indexWhere((item)=> item.product.id == event.productId);

    if(index >=0){
      if(event.quantity <=0){
        currentItems.removeAt(index);
      }else{
        final item = currentItems[index];
        final maxStock =item.product.stock;
        final validQuantity =(maxStock >0 && event.quantity >maxStock)?maxStock :event.quantity;
        currentItems[index] =item.copyWith(quantity: validQuantity);
      }
      emit(CartLoaded(items: currentItems));
    }
  }

  void _clearCart(clearCart event, Emitter<CartState> emit){
    emit(const CartLoaded(items: []));
  }
}