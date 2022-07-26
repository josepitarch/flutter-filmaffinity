import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MetadataShimmer extends StatelessWidget {
  const MetadataShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: const [
                  _HeaderShimmer(),
                  _GenresShimmer(),
                  _CastShimmer(),
                  _SynopsisShimmer(),
                  _JustwatchShimmer(),
                  _ReviewsShimmer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderShimmer extends StatelessWidget {
  const _HeaderShimmer({Key? key}) : super(key: key);

  final double _height = 220;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
            flex: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: Colors.grey[200],
                height: _height,
              ),
            )),
        Flexible(flex: 5, child: Container()),
        Flexible(
          flex: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 25,
                    width: 150,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 20,
                    width: 120,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20,
                      width: 30,
                      color: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20,
                      width: 60,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 20,
                  width: 100,
                  color: Colors.grey[200],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 30,
                          width: 45,
                          color: Colors.grey[200],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 30,
                          width: 45,
                          color: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _GenresShimmer extends StatelessWidget {
  const _GenresShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(spacing: 10, runSpacing: 10, children: [
          for (int i = 0; i < 3; i++)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.blue,
                width: 110,
                height: 30,
              ),
            )
        ]),
      ),
    );
  }
}

class _CastShimmer extends StatelessWidget {
  const _CastShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 30,
              width: 100,
              color: Colors.grey[200],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 70,
            width: double.infinity,
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}

class _SynopsisShimmer extends StatelessWidget {
  const _SynopsisShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 30,
              width: 100,
              color: Colors.grey[200],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}

class _JustwatchShimmer extends StatelessWidget {
  const _JustwatchShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(spacing: 10, runSpacing: 10, children: [
            for (int i = 0; i < 3; i++)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.blue,
                  width: 70,
                  height: 30,
                ),
              )
          ]),
        ),
        const SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(spacing: 15, runSpacing: 10, children: [
            for (int i = 0; i < 4; i++)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.blue,
                  width: 70,
                  height: 75,
                ),
              )
          ]),
        ),
      ]),
    );
  }
}

class _ReviewsShimmer extends StatelessWidget {
  const _ReviewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 30,
              width: 100,
              color: Colors.grey[200],
            ),
          ),
        ),
        for (int i = 0; i < 3; i++)
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20,
                      width: 140,
                      color: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              )
            ],
          )
      ],
    );
  }
}
