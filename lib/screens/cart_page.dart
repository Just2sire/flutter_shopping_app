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
      body: context.watch<CartProvider>().cart.isEmpty
          ? Center(
              child: Text(
                "Empty Cart",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            )
          : SizedBox(
              child: ListView.builder(
                // itemCount: cart.length,
                itemCount: context.watch<CartProvider>().cart.length,
                itemBuilder: (context, index) {
                  final cartItem = context.watch<CartProvider>().cart[index];
                  debugPrint(
                      context.watch<CartProvider>().cart.length.toString());
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
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Delete Product",
                                    style:
                                        Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 28),
                                  ),
                                  content: const Text(
                                    "Are you sure you want to remove the product from the cart ?",
                                    // style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .removeProduct(id);
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("Product deleted"),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
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
