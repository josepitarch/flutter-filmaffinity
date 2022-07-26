import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  final String title;
  const TitlePage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
