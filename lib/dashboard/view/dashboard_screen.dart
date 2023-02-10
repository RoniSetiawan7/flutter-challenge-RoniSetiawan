import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/bloc/product_bloc.dart';

import 'product_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc()..add(InitializeProduct()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('List of Products'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.product.length,
              itemBuilder: ((context, index) {
                final products = state.product[index];
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Text(
                        products.title,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Text(
                      'Stock : ${products.stock.toString()}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    leading: Image.network(
                      products.thumbnail ?? '',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    trailing: Builder(builder: (context) {
                      if (products.discountPercentage != null) {
                        return Wrap(
                          children: [
                            Text(
                              '${products.discountPercentage}%',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  '\$ ${products.price.toString()}',
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '\$ ${(products.price - (products.price * products.discountPercentage!) / 100).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Text(
                          '\$ ${products.price.toString()}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        );
                      }
                    }),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: products,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
