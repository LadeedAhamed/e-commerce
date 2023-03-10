import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../app/pages/user/user_bag.dart';

class UserTopBar extends StatelessWidget {
  final IconButton leadingIconButton;
  const UserTopBar({Key? key, required this.leadingIconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const UserOrders()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserBag()));
          },
        ),
      ],
    );
  }
}
