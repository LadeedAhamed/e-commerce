import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/providers.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'admin_add_product.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(firebaseAuthProvider).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: ref.read(databaseProvider)!.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ListTile(
                  leading: product.imageUrl != ""
                      ? Image.network(product.imageUrl)
                      : Container(),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => ref
                          .read(databaseProvider)!
                          .deleteProduct(product.id!)),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AdminAddProductPage())),
      ),
    );
  }
}
