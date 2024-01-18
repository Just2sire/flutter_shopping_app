import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/screens/homepage.dart';
import 'package:shopping_app/screens/product_detail.dart';


class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filterBy = const [
    "All",
    "Adidas",
    "Nike",
    "Puma",
    "Reebok",
    "Gillette",
    "Tommy Hilfiger"
  ];
  late String selectedFilter;

  @override
  void initState() {
    selectedFilter = filterBy.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Shoes\nCollection",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterBy.length,
                itemBuilder: (context, index) {
                  final filter = filterBy[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        label: Text(filter),
                        labelStyle: const TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    if (products[index]
                        case {
                          'title': String title,
                          'price': double price,
                          'imageUrl': String imageUrl
                        }) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                product: products[index],
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          title: title,
                          price: price,
                          imageUrl: imageUrl,
                          backgroundColor: index.isOdd
                              ? const Color.fromRGBO(225, 225, 225, 1)
                              : const Color.fromRGBO(216, 240, 253, 1),
                        ),
                      );
                    } else {
                      return throw "Data types incorrect";
                    }
                  },
                ),
              ),
            )
          ],
        ),
      );
  }
}