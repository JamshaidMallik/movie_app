import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../widgets/movie_card_widget.dart';
import 'show_favorite_movie_screen.dart';
import '../../controller/movie_controller.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MovieController controller = Get.put(MovieController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Movies',
          style: bigFontStyle(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: GetBuilder<MovieController>(builder: (c) {
              return IconButton(
                  onPressed: ()=> Get.to(const FavoriteMoviesScreen()),
                  icon: Badge(
                   isLabelVisible: c.visibleList.any((element) => element.isSelected == true) ? true : false,
                      label: Text(
                        c.visibleList.where((element) => element.isSelected == true).length.toString(),
                        style: TextStyle(color: whiteColor),
                      ),
                      child: const Icon(Icons.favorite_border_outlined)));
            }),
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: whiteColor,
        color: primaryColor,
        onRefresh: () => controller.onRefreshMovie(),
        child: Column(
          children: [
            /// CupertinoSearchTextField is used to search the movie
            CupertinoSearchTextField(
              onChanged: (value) => controller.searchMovies(value),
              placeholder: 'Search',
              style: const TextStyle(color: Colors.black),
              placeholderStyle: const TextStyle(color: Colors.black),
              prefixInsets: const EdgeInsets.all(10),
              suffixInsets: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
            ),
            /// Expanded widget is used to make the listview scrollable
            Expanded(
                child: FutureBuilder(
                    future: controller.fetchMovies(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: primaryColor,
                        ));
                      } else if (snapshot.hasData) {
                        return GetBuilder<MovieController>(
                          builder: (c) {
                            if (c.visibleList.isNotEmpty) {
                              return ListView.builder(
                                controller: c.scrollController,
                                itemCount: c.visibleList.length + 1,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (index < c.visibleList.length) {
                                    var item = c.visibleList[index];
                                    return MovieCardWidget(item: item);
                                  } else {
                                    return loadingWidget(c);
                                  }
                                });
                            } else {
                              if(c.movieList.isEmpty) {
                                return Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ));
                              }
                              return const Center(
                              child: Text('No Match Found'),
                            );
                            }
                          }
                        );
                      } else{
                        return const Center(child: Text('Error On Fetching Data'));
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
/// loading for pagination
// ignore: camel_case_types
class loadingWidget extends StatelessWidget {
  final MovieController controller;
  const loadingWidget(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
          child: controller.hasMore ? CupertinoActivityIndicator(color: primaryColor) : const Text('has no more data')),
    );
  }
}
