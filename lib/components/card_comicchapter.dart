import 'package:flutter/material.dart';
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';
import 'package:remixicon/remixicon.dart';

class ComicChapter extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget intent;

  ComicChapter(
      {required this.title, required this.subtitle, required this.intent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => intent));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: MyColors().SECONDARY, width: 1)),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: MyTexts().subheader,
                    ),
                    Text(
                      this.subtitle,
                      style: MyTexts().text,
                    )
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: MyColors().SILVER, shape: BoxShape.circle),
                child: Icon(
                  Remix.arrow_right_s_line,
                  color: MyColors().SECONDARY,
                  size: 32,
                ),
              )
            ],
          ),
        ));
  }
}
