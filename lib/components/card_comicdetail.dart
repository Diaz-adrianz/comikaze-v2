import 'package:flutter/material.dart';

// MY SYTLE
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';

class ComicDetail extends StatelessWidget {
  final String image_uri;
  final String title;
  final String type;
  final String updatedOn;
  final Widget intent;

  ComicDetail(
      {required this.image_uri,
      required this.title,
      required this.type,
      required this.updatedOn,
      required this.intent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => intent));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 100,
            height: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 1),
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  image: NetworkImage(image_uri),
                )),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: MyTexts().subheader,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                margin: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: MyColors().PRIMARY_TINT),
                child: Text(
                  type,
                  style: MyTexts().mini_text,
                ),
              ),
              Text(
                updatedOn,
                style: MyTexts().mini_text_s,
              ),
            ],
          )),
        ]),
      ),
    );
  }
}
