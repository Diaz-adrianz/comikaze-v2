import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/models/local.dart';
import 'package:mobile/services/local.dart';
import 'package:remixicon/remixicon.dart';

// mine
import 'package:mobile/style/texts.dart';
import 'package:mobile/style/colors.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/chapter.dart';
import '../services/comics.dart';

// my component
// import 'package:mobile/components/card_comichero.dart';

class ReadPage extends StatefulWidget {
  final String title;
  final String endpoint;
  const ReadPage(this.title, this.endpoint, {super.key});

  @override
  _ReadPageState createState() => _ReadPageState(title, endpoint);
}

class _ReadPageState extends State<ReadPage> {
  String title;
  String endpoint;
  bool _isLoading = false;
  ChapterModel? _chapters;

  _ReadPageState(this.title, this.endpoint);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });

      var callChapter = ComicCall(context, 'chapter/${endpoint}', {}, false);
      ChapterModel comic = await callChapter.get(callChapter.getChapters());

      setState(() {
        _chapters = comic;
        _isLoading = false;
      });

      setHistory();
    });
  }

  void setHistory() async {
    List<LocalSaveModel> hists = [];
    List<LocalSaveModel> newHists = [];

    LocalSave local = LocalSave('histo', hists);
    hists = await local.get();

    for (LocalSaveModel h in hists) {
      if (h.title != title) {
        newHists.add(h);
      }
    }

    LocalSaveModel newHist = LocalSaveModel();
    newHist.title = title;
    newHist.subtitle = _chapters?.chapterName;
    newHist.endpoint = _chapters?.chapterEndpoint;
    newHist.thumb = _chapters?.chapterImage![0].chapterImageLink;
    newHist.updated_on = '';

    newHists.insert(0, newHist);

    local.data = newHists;
    local.set();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().BLACK,
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
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      "Kembali",
                      style: MyTexts().subheader_w,
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              children: <Widget>[
                ListView(
                  // shrinkWrap: true,
                  children: [
                    for (ChapterImage img in _chapters!.chapterImage!)
                      Container(
                          width: MediaQuery.of(context).size.width,
                          constraints: const BoxConstraints(minHeight: 300),
                          child: InteractiveViewer(
                              boundaryMargin: EdgeInsets.all(0),
                              minScale: 1,
                              maxScale: 3,
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: img.chapterImageLink.toString(),
                              ))),
                    const SizedBox(
                      height: 90,
                    )
                  ],
                ),
                Positioned(
                  top: 32,
                  left: 24,
                  child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(4),
                      // ignore: unnecessary_new
                      decoration: new BoxDecoration(
                          color: MyColors().BLACK, shape: BoxShape.circle),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.zero),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Remix.arrow_left_s_line,
                          color: MyColors().WHITE,
                          size: 32,
                        ),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    color: MyColors().BLACK,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              padding: EdgeInsets.zero),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ReadPage(
                                        title,
                                        _chapters!.chapterPrevEndpoint
                                            .toString())));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Icon(
                              Remix.arrow_left_s_line,
                              color: MyColors().WHITE,
                              size: 32,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _chapters!.chapterName.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: MyTexts().text_w,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              padding: EdgeInsets.zero),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ReadPage(
                                        title,
                                        _chapters!.chapterNextEndpoint
                                            .toString())));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Icon(
                              Remix.arrow_right_s_line,
                              color: MyColors().WHITE,
                              size: 32,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
