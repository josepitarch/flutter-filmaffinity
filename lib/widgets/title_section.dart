import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
