import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/Model/movie_model.dart';
import '../controller/movie_controller.dart';
import '../constant/constant.dart';

class MovieCardWidget extends GetView<MovieController> {
  final MovieModel item;
  const MovieCardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MovieController(),
      builder: (ctr) {
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
                      child: Image.network(
                        item.backgroundImage.toString(),
                        height: kSize.height * 0.25,
                        width: kSize.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 10,
                      child: InkWell(
                        onTap: () => controller.selectItem(item),
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
                      ),)
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
                      movieDetailRow(heading: 'Genres',body: item.genres!.join(', ').toUpperCase(),),
                      movieDetailRow(heading: 'Rating', body:  item.rating != 0?  item.rating.toString() : 'N/A',),
                      movieDetailRow(heading: 'Language', body: item.language.toString().toUpperCase(),),
                      movieDetailRow(heading: 'Uploaded', body: DateFormat('dd-MMM-yyyy').format(DateTime.parse(item.uploadedDate!))),

                    ],
                  ),
                )
              ],
            )
          ),
        );
      }
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
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}




