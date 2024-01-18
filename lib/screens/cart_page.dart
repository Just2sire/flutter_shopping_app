import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: ListView.builder(
          // itemCount: cart.length,
          itemCount: context.watch<CartProvider>().cart.length,
          itemBuilder: (context, index) {
            final cartItem = context.watch<CartProvider>().cart[index];
            debugPrint(context.watch<CartProvider>().cart.length.toString());
            if (cartItem
                case {
                  'id': String id,
                  'title': String title,
                  // 'price': double price,
                  'imageUrl': String imageUrl,
                  // 'company': String company,
                  'size': int size,
                }) {
              return ListTile(
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text("Size: $size"),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    imageUrl,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    context.read<CartProvider>().removeProduct(id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              );
            } else {
              throw "Invalid DataType";
            }
          },
        ),
      ),
    );
  }
}
