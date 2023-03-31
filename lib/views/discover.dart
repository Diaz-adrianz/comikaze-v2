import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'dart:async';

// MY STYLE
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';

// MY COMPOENNET
import 'package:mobile/components/inputicon.dart';
import 'package:mobile/components/card_comicdetail.dart';

// PAGES
import 'package:mobile/views/detail.dart';

import '../models/comics.dart';
import '../services/comics.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _search = TextEditingController();

  bool _isLoading = false;
  List<Comic> _comics = [];

  void searchComics(String q) async {
    setState(() {
      _isLoading = true;
    });

    List<Comic> comics = [];
    if (q.isNotEmpty) {
      // Timer(const Duration(seconds: 1), () async {
      var callComics = ComicCall(context, 'search/$q', {}, false);
      comics = await callComics.get(callComics.getComics());
      // });
    }

    setState(() {
      _comics = comics;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().WHITE,
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover',
                      style: MyTexts().header,
                    ),
                    _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: MyColors().PRIMARY,
                            ),
                          )
                        : Text(
                            _comics.length.toString(),
                            style: MyTexts().mini_text_w,
                          ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: InputIcon(
                    _search, searchComics, 'Cari disini...', Remix.search_line),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 90),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _comics.isEmpty
                        ? Center(
                            child: Container(
                              width: 250,
                              height: 250,
                              margin: const EdgeInsets.only(top: 32),
                              child: Image.asset('assets/images/null.png'),
                            ),
                          )
                        : const SizedBox(),
                    for (Comic com in _comics)
                      ComicDetail(
                          image_uri: com.thumb.toString(),
                          title: com.title.toString(),
                          type: com.type.toString(),
                          updatedOn: com.updatedOn.toString(),
                          intent: DetailPage(com.endpoint.toString()))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
