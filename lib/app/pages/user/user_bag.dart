import 'package:e_commerce/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';

class UserBag extends ConsumerWidget {
  const UserBag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final bagViewModel = ref.watch(bagProvider);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); //. Go back a screen
                  },
                ),
                const Flexible(
                  child: Text(
                    "My Bag",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
            bagViewModel.productsBag.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const EmptyWidget())
                : Flexible(
                    child: ListView.builder(
                    itemCount: bagViewModel.totalProducts,
                    itemBuilder: (context, index) {
                      final product = bagViewModel.productsBag[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('\$' + product.price.toString()),
                        trailing: IconButton(
                            onPressed: () {
                              bagViewModel.removeProduct(product);
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                  )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: \$" + bagViewModel.totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final payment = ref.read(paymentProvider);
                        final user = ref.read(authStateChangesProvider);
                        final userBag = ref.watch(bagProvider);

                        final result = await payment.initPaymentSheet(
                            user.value!, userBag.totalPrice);

                        if (!result.isError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Payment completed!')),
                          );
                          userBag.clearBag();
                          Navigator.pop(context);
                        } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result.message),
                            ),
                          );
                        }
                      },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
