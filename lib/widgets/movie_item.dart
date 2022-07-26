import 'package:flutter/material.dart';
import 'package:scrapper_filmaffinity/models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final bool? hasAllAttributes;

  const MovieItem({Key? key, required this.movie, this.hasAllAttributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 170.0;
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> arguments = {
          'id': movie.id,
          'movie': movie,
          'isOpened': hasAllAttributes ?? false,
        };
        Navigator.pushNamed(context, 'details', arguments: arguments);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                  height: height,
                  width: 120,
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.poster),
                  placeholder: const AssetImage('assets/loading.gif'),
                  imageErrorBuilder: (_, __, ___) => Image.asset(
                      'assets/no-image.jpg',
                      height: height,
                      fit: BoxFit.cover,
                      width: 120)),
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(fontSize: 19),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      movie.director ?? '',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                )),
          ),
          SizedBox(
              height: height,
              child: const Icon(Icons.arrow_forward_ios_outlined))
        ]),
      ),
    );
  }
}
