import 'package:flutter/material.dart';
import 'package:mobile/components/inputselect.dart';
import 'package:mobile/models/genres.dart';
import 'package:remixicon/remixicon.dart';

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

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _isLoading = false;
  List<Comic> _comics = [];

  Genre _comicTypeSelected = Genre(genreName: 'Manga', endpoint: 'manga');
  Genre _comicGenreSelected = Genre(genreName: 'Action', endpoint: 'action');

  final List<Genre> _comicType = [
    Genre(genreName: 'Random', endpoint: 'acak'),
    Genre(genreName: 'Manga', endpoint: 'manga'),
    Genre(genreName: 'Manhua', endpoint: 'manhua'),
    Genre(genreName: 'Manhwa', endpoint: 'manhwa'),
  ];

  List<Genre> _comicGenre = [Genre(genreName: 'Action', endpoint: 'action')];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });

      var callGenres = ComicCall(context, 'genres', {}, false);
      List<Genre> genres = await callGenres.get(callGenres.getGenres());

      setState(() {
        _isLoading = false;
        _comicGenre = genres;
      });
    });
  }

  void setComicTypeSelected(Genre select) {
    setState(() => _comicTypeSelected = select);
  }

  void setComicGenreSelected(Genre select) {
    setState(() => _comicGenreSelected = select);
  }

  void getComics(ctx) async {
    setState(() {
      _isLoading = true;
    });

    var callComics = ComicCall(
        ctx,
        'genres/${_comicGenreSelected.endpoint}/${_comicTypeSelected.endpoint}',
        {},
        false);
    List<Comic> comics = await callComics.get(callComics.getComics());

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
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Genre Filter',
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
                        : const SizedBox(
                            height: 4,
                          ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,

                  children: [
                    Expanded(
                      child: InputSelect(context, _comicTypeSelected,
                          setComicTypeSelected, _comicType),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: InputSelect(context, _comicGenreSelected,
                          setComicGenreSelected, _comicGenre),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        getComics(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: MyColors().PRIMARY, shape: BoxShape.circle),
                        child: Icon(
                          Remix.search_line,
                          color: MyColors().WHITE,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                ),
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
                        : Text(
                            _comics.length.toString(),
                            style: MyTexts().mini_text_w,
                          ),
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
