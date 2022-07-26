import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:scrapper_filmaffinity/pages/favorite_movies_screen.dart';
import 'package:scrapper_filmaffinity/pages/search_movie.dart';
import 'package:scrapper_filmaffinity/pages/top_movies_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scrapper_filmaffinity/ui/custom_icons.dart';
import 'package:scrapper_filmaffinity/widgets/section_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = const [
    SectionList(),
    SearchMovieScreen(),
    FavouritesMovies(),
    TopMoviesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1.5))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange[600],
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 16,
          unselectedFontSize: 14,
          onTap: (index) async {
            bool canVibrate = await Vibrate.canVibrate;

            if (canVibrate) {
              Vibrate.feedback(FeedbackType.medium);
            }
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.home,
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.search,
              icon: const Icon(Icons.search_outlined),
            ),
            BottomNavigationBarItem(
                icon: const Icon(MyIcons.heartEmpty),
                label: AppLocalizations.of(context)!.favorites),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.top,
              icon: const Icon(Icons.list_alt_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
