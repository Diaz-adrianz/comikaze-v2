import 'package:flutter/material.dart';

import '../style/texts.dart';

class ComicHero extends StatelessWidget {
  final String image_uri;
  final String title;
  final String path;
  final Widget intent;

  ComicHero(
      {required this.image_uri,
      required this.title,
      required this.path,
      required this.intent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => intent));
        },
        child: Container(
          margin: EdgeInsets.only(right: 16),
          width: 180,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 180,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image(
                      image: NetworkImage(this.image_uri, scale: 1.0),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MyTexts().subheader_w,
              ),
            ],
          ),
        ));
  }
}
