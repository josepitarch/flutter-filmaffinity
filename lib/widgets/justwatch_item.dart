import 'package:flutter/material.dart';

class JustwatchItem extends StatelessWidget {
  const JustwatchItem({Key? key, required this.asset}) : super(key: key);

  final String asset;

  @override
  Widget build(BuildContext context) {
    // TODO: change size of asset
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/justwatch/$asset.jpg',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(),
        ),
      ),
    );
  }
}
