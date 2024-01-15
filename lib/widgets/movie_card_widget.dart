import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/Model/Movie.dart';
import '../controller/movie_controller.dart';
import '../constant/constant.dart';

class MovieCardWidget extends GetView<MovieController> {
  final Movie item;
  const MovieCardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: greyColor.withOpacity(0.1),
      borderOnForeground: true,
      semanticContainer: true,
      shadowColor: Colors.grey,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: item.backgroundImage!,
                      height: kSize.height * 0.25,
                      width: kSize.width,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        'assets/placeholder.jpg',
                        fit: BoxFit.cover,
                        height: kSize.height * 0.25,
                        width: kSize.width,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  GetBuilder<MovieController>(builder: (c) {
                    return Positioned(
                      top: 15,
                      right: 10,
                      child: InkWell(
                        onTap: () => c.favToggleFunction(item),
                        child: CircleAvatar(
                          radius: 17.0,
                          backgroundColor: Colors.white60,
                          child: Center(
                            child: Icon(
                              item.isSelected! ? Icons.favorite : Icons.favorite,
                              color: item.isSelected! ? Colors.red : Colors.grey,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.titleLong.toString().toUpperCase(),
                      style: secondaryFontStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    5.height,
                    movieDetailRow(
                      heading: 'Rating',
                      body: item.rating != 0 ? item.rating.toString() : 'N/A',
                    ),
                    movieDetailRow(
                      heading: 'Language',
                      body: item.language.toString().toUpperCase(),
                    ),
                    if (item.uploadedDate != null)
                      movieDetailRow(heading: 'Uploaded', body: DateFormat('dd-MMM-yyyy').format(DateTime.parse(item.uploadedDate.toString()))),
                    5.height,
                    Row(
                      children: [
                        Text(
                          'Genres: ',
                          style: secondaryFontStyle(fontWeight: FontWeight.w600, fontSize: 10.0),
                        ),
                        Text(
                          item.genres!.join(', ').toUpperCase(),
                          style: greyFontStyle(fontWeight: FontWeight.w600, fontSize: 8.0),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class movieDetailRow extends StatelessWidget {
  const movieDetailRow({
    super.key,
    required this.heading,
    required this.body,
  });
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$heading: ',
          style: secondaryFontStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
        ),
        Text(
          body,
          style: greyFontStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
        ),
      ],
    );
  }
}
