import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/components/card_comicdetail.dart';
import 'package:mobile/models/comic.dart';
import 'package:mobile/views/read.dart';
import 'package:remixicon/remixicon.dart';

// mine
import 'package:mobile/style/texts.dart';
import 'package:mobile/style/colors.dart';

import '../models/chapters.dart';
import '../models/comics.dart';
import '../services/comics.dart';

// MY COMPONENTS
class DetailPage extends StatefulWidget {
  final String endpoint;
  const DetailPage(this.endpoint, {super.key});

  @override
  _DetailPageState createState() => _DetailPageState(endpoint);
}

class _DetailPageState extends State<DetailPage> {
  String endpoint;
  bool _isLoading = false;
  ComicModel? _comic;
  List<ChaptersModel>? _chapters;

  _DetailPageState(this.endpoint);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });

      var callComic = ComicCall(context, 'detail/${endpoint}', {}, false);
      ComicModel comic = await callComic.get(callComic.getDetail());

      setState(() {
        _comic = comic;
        _chapters = comic.chapter!;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().WHITE,
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      color: MyColors().PRIMARY,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: MyColors().SILVER,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: Text(
                      "Kembali",
                      style: MyTexts().subheader_s,
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                child: Center(
                                    child: Icon(
                                  Remix.arrow_left_s_line,
                                  color: MyColors().BLACK,
                                  size: 32,
                                )),
                              )),
                          const Spacer(),
                          Text(
                            _comic!.type.toString(),
                            style: MyTexts().header,
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                child: Center(
                                    child: Icon(
                                  Remix.share_line,
                                  color: MyColors().BLACK,
                                  size: 32,
                                )),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 250,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image(
                                image: NetworkImage(_comic!.thumb.toString(),
                                    scale: 1.0),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    padding: EdgeInsets.zero),
                                onPressed: () {},
                                child: Container(
                                  width: 48,
                                  padding: const EdgeInsets.all(8),
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: MyColors().PRIMARY_TINT,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Remix.heart_fill,
                                    color: MyColors().PRIMARY,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    padding: EdgeInsets.zero),
                                onPressed: () {},
                                child: Container(
                                  width: 48,
                                  padding: const EdgeInsets.all(8),
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: MyColors().SILVER,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Remix.bookmark_line,
                                    color: MyColors().SECONDARY,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              _isLoading
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: MyColors().PRIMARY,
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 4,
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _comic!.title.toString(),
                              style: MyTexts().header,
                            ),
                            Text(
                              _comic!.genreList!.join(', '),
                              style: MyTexts().text,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Divider(
                              color: MyColors().SECONDARY,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Remix.open_arm_line,
                                  color: MyColors().SECONDARY,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                  _comic!.age.toString(),
                                  style: MyTexts().text_s,
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Remix.user_star_line,
                                  color: MyColors().SECONDARY,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                  _comic!.author.toString(),
                                  style: MyTexts().text_s,
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Remix.information_line,
                                  color: MyColors().SECONDARY,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                  _comic!.status.toString(),
                                  style: MyTexts().text_s,
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Divider(
                              color: MyColors().SECONDARY,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              _comic!.synopsis.toString(),
                              style: MyTexts().text_s,
                            ),
                            const SizedBox(
                              height: 90,
                            )
                          ]),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: MyColors().WHITE,
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: MyColors().SECONDARY))),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: MyColors().PRIMARY),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => ReadPage(
                                                  _comic!.title.toString(),
                                                  _chapters![
                                                          _chapters!.length - 1]
                                                      .chapterEndpoint
                                                      .toString())));
                                    },
                                    child: Text(
                                      'Baca Sekarang',
                                      style: MyTexts().subheader_w,
                                    ),
                                  ),
                                  Container(
                                    height: 24,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: VerticalDivider(
                                      color: MyColors().WHITE,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                          )),
                                          builder: (context) {
                                            return DraggableScrollableSheet(
                                              expand: false,
                                              // initialChildSize: 0.5,
                                              maxChildSize: 0.9,
                                              minChildSize: 0.25,
                                              builder:
                                                  (context, scrollController) {
                                                return Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(24, 0, 24, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            width: 100,
                                                            height: 8,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8),
                                                            decoration: BoxDecoration(
                                                                color: MyColors()
                                                                    .SECONDARY,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: ListView(
                                                          controller:
                                                              scrollController,
                                                          shrinkWrap: true,
                                                          children: [
                                                            for (ChaptersModel chapter
                                                                in _chapters!)
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(context).push(MaterialPageRoute(
                                                                      builder: (context) => ReadPage(
                                                                          _comic!
                                                                              .title
                                                                              .toString(),
                                                                          chapter
                                                                              .chapterEndpoint
                                                                              .toString())));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 8),
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors().SILVER))),
                                                                  child: Text(
                                                                    chapter
                                                                        .chapterTitle
                                                                        .toString(),
                                                                    style: MyTexts()
                                                                        .subheader,
                                                                  ),
                                                                ),
                                                              )
                                                          ],
                                                        ))
                                                      ],
                                                    ));
                                              },
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Remix.arrow_up_s_line,
                                      color: MyColors().WHITE,
                                    ),
                                  )
                                ],
                              )),
                        )))
              ],
            ),
    );
  }
}
