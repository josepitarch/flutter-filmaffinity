import 'package:flutter/material.dart';
import 'package:scrapper_filmaffinity/models/movie.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          review.body.replaceAll("\"", ''),
          style: const TextStyle(height: 1.25, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              review.author,
            ),
            buildInclination(review.inclination)
          ],
        )
      ],
    );
  }

  Container buildInclination(String inclination) {
    Color backgroundColor;
    if (inclination == 'positive') {
      backgroundColor = Colors.green;
    } else if (inclination == 'negative') {
      backgroundColor = Colors.red;
    } else {
      backgroundColor = Colors.yellow;
    }
    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
