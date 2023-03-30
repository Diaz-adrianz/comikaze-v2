import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/components/card_comicchapter.dart';
import 'package:mobile/services/comics.dart';
import 'package:mobile/services/local.dart';
import 'package:mobile/style/colors.dart';
import 'package:mobile/views/read.dart';
import 'package:remixicon/remixicon.dart';

// mine
import 'package:mobile/services/auth.dart';
import 'package:mobile/style/texts.dart';
import 'package:mobile/views/login.dart';

// my component
import 'package:mobile/components/card_comichero.dart';

// PAGES
import 'package:mobile/views/history.dart';

import '../models/comics.dart';
import '../models/local.dart';
import 'about.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Comic> _hotComic = [];
  List<LocalSaveModel>? _history;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LocalSave local = LocalSave('histo', <LocalSaveModel>[]);
      List<LocalSaveModel> localComics = await local.get();

      setState(() {
        _history = localComics;
        _isLoading = true;
      });

      var call_hotComic = ComicCall(context, 'hot/acak', {}, false);
      List<Comic> comics = await call_hotComic.get(call_hotComic.getComics());

      setState(() {
        _hotComic = comics.sublist(0, 10);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().WHITE,
      body: Stack(
        children: <Widget>[
          ListView(children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
              color: MyColors().PRIMARY,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ohayou, Darling',
                          style: MyTexts().header_w,
                        ),
                        _isLoading
                            ? Container(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: MyColors().WHITE,
                                ),
                              )
                            : const SizedBox(
                                height: 4,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24),
                    height: 210,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (Comic hot in _hotComic)
                          ComicHero(
                            image_uri: hot.thumb.toString(),
                            title: hot.title.toString(),
                            path: hot.endpoint.toString(),
                            intent: DetailPage(hot.endpoint.toString()),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _history != null
                ? Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lanjutkan bacanya!',
                            style: MyTexts().text,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ComicChapter(
                              title: _history![0].title.toString().replaceAll(
                                  'Komik', ''),
                              subtitle: _history![0]
                                  .subtitle
                                  .toString()
                                  .replaceAll(
                                      _history![0]
                                          .title
                                          .toString()
                                          .replaceAll('Komik ', '')
                                          .toLowerCase(),
                                      ''),
                              intent: ReadPage(_history![0].title.toString(),
                                  _history![0].endpoint.toString()))
                        ]),
                  )
                : const SizedBox(
                    height: 24,
                  ),
            Container(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 90),
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24),
                  children: [
                    CardMenu(
                        context, Remix.history_fill, 'Riwayat', HistoryPage()),
                    CardMenu(
                        context, Remix.heart_fill, 'Favorit', HistoryPage()),
                    CardMenu(context, Remix.bookmark_fill, 'Disimpan',
                        HistoryPage()),
                    CardMenu(context, Remix.information_fill, 'Tentang',
                        AboutPage()),
                  ],
                ))
          ])
        ],
      ),
    );
  }
}

Widget CardMenu(BuildContext ctx, IconData iconn, String text, Widget intent) {
  return GestureDetector(
    onTap: () {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => intent));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
          color: MyColors().SILVER, borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        Container(
          width: 52,
          padding: const EdgeInsets.all(8),
          height: 52,
          decoration: BoxDecoration(
              color: MyColors().PRIMARY_TINT, shape: BoxShape.circle),
          child: Icon(
            iconn,
            color: MyColors().PRIMARY,
            size: 36,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          text,
          style: MyTexts().subheader,
        )
      ]),
    ),
  );
}
