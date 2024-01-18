import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';

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
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];
            if (cartItem
                case {
                  'title': String title,
                  'price': double price,
                  'imageUrl': String imageUrl,
                  'company': String company,
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
                  onPressed: () {},
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
