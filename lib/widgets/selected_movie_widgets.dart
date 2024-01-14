import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_app/Model/movie_model.dart';
import '../constant/constant.dart';

class SelectedMovieWidget extends StatelessWidget {
  final MovieModel item;
  final bool isSelected;
  final VoidCallback? onTap;

  const SelectedMovieWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      borderOnForeground: true,
      semanticContainer: true,
      shadowColor: randomColor[Random().nextInt(randomColor.length)],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: onTap != null
              ? () {
            onTap!();
          }: null,
          leading: Checkbox(
            value: isSelected,
            onChanged: (value) {
              // Do nothing
            },
          ),
          title: Text(
            item.title.toString().toUpperCase(),
            style: secondaryFontStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.id.toString(),
                      style: greyFontStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ).copyWith(
                        color:
                        randomColor[Random().nextInt(randomColor.length)],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              Text(
                item.body.toString(),
                style: greyFontStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
              const Divider(),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}