import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            child: ListTile(
              leading: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(item.backgroundImage.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () => controller.selectItem(item),
                icon: Icon(
                  item.isSelected! ? Icons.favorite : Icons.favorite,
                  color: item.isSelected! ? Colors.red : Colors.grey,
                ),
              ),
              title: Text(
                item.titleLong.toString().toUpperCase(),
                style: secondaryFontStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle:   Text(
                item.body.toString(),
                style: greyFontStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
              isThreeLine: true,
            ),
          ),
        );
      }
    );
  }
}




