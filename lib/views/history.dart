import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/services/local.dart';
import 'package:mobile/views/read.dart';
import 'package:remixicon/remixicon.dart';

// mine
import 'package:mobile/style/texts.dart';
import 'package:mobile/style/colors.dart';

// my component
import 'package:mobile/components/card_comicchapter.dart';

import '../models/local.dart';
// import 'package:mobile/components/card_comichero.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLoading = false;
  LocalSave? _localSave;
  List<LocalSaveModel>? _history = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });

      LocalSave local = LocalSave('histo', _history!);
      List<LocalSaveModel> data = await local.get();

      setState(() {
        _localSave = local;
        _history = data;
        _isLoading = false;
      });
    });
  }

  void _handleDeleteHistory(int i) async {
    List<LocalSaveModel> histsToDel = _history!;

    histsToDel.removeAt(i);

    _localSave!.data = histsToDel;
    _localSave!.set();

    setState(() {
      _history = histsToDel;
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
                        padding: const EdgeInsets.all(16),
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
                          Text(
                            'Riwayat Baca',
                            style: MyTexts().header,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'TIPS: Tekan lama untuk hapus',
                              style: MyTexts().mini_text_s,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            for (LocalSaveModel item in _history!)
                              GestureDetector(
                                onLongPress: () {
                                  // print(_history!.indexOf(item));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: MyColors().BLACK,
                                    content: Text(
                                      'Lanjutkan hapus ${item.title.toString()}? ',
                                      style: MyTexts().mini_text_w,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    action: SnackBarAction(
                                      label: 'Ya',
                                      textColor: Colors.red,
                                      onPressed: () {
                                        _handleDeleteHistory(
                                            _history!.indexOf(item));
                                      },
                                    ),
                                  ));
                                },
                                child: ComicChapter(
                                    title: item.title
                                        .toString()
                                        .replaceAll('Komik', ''),
                                    subtitle: item.subtitle
                                        .toString()
                                        .replaceAll(
                                            item.title
                                                .toString()
                                                .replaceAll('Komik ', '')
                                                .toLowerCase(),
                                            ''),
                                    intent: ReadPage(item.title.toString(),
                                        item.endpoint.toString())),
                              )
                          ],
                        ))
                  ],
                )
              ],
            ),
    );
  }
}
