import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

// mine
import 'package:mobile/style/texts.dart';
import 'package:mobile/style/colors.dart';

// my component
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../services/auth.dart';
// import 'package:mobile/components/card_comichero.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String code = '';
  bool _isLogoutLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? myCode = await CheckLogin(context);

      setState(() {
        code = myCode!;
      });
    });
  }

  void _handleLogout(BuildContext ctx) async {
    setState(() {
      _isLogoutLoading = true;
    });
    var call = AuthCall(ctx, 'account/logout', {'code': code}, true);

    await call.post(call.logout());

    setState(() {
      _isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().WHITE,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
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
                      'Tentang',
                      style: MyTexts().header,
                    ),
                    const Spacer(),
                    _isLogoutLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: MyColors().PRIMARY,
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                                _handleLogout(context);
                              },
                              child: const Icon(
                                Remix.logout_circle_line,
                                color: Colors.redAccent,
                                size: 32,
                              ),
                            )),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 90),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          code,
                          style: TextStyle(
                              fontSize: 64,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: MyColors().BLACK,
                              letterSpacing: 12),
                        ),
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
                        'Jaga baik-baik kode akses anda.',
                        style: MyTexts().text,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      LinkCard(
                          title: 'Comikaze?',
                          link:
                              'https://docs.google.com/document/d/1Vi3GN2JznHFsc-cGaQuzm8c47_oj2_8QW6ZyrFANkJ4/edit?usp=share_link'),
                      LinkCard(
                          title: 'Kesepakatan Pengguna',
                          link:
                              'https://docs.google.com/document/d/1Vi3GN2JznHFsc-cGaQuzm8c47_oj2_8QW6ZyrFANkJ4/edit?usp=share_link'),
                      LinkCard(
                          title: 'Donasi ☕',
                          link: 'https://link.dana.id/qr/xuxue3sh'),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class LinkCard extends StatelessWidget {
  final String title;
  final String link;

  LinkCard({required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (!await launch(link, forceWebView: false)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'URL tidak bisa dibuka',
                  style: MyTexts().mini_text_w,
                )));
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: MyColors().SECONDARY, width: 1)),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.title,
                style: MyTexts().subheader,
              ),
              Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(4),
                decoration: new BoxDecoration(
                    color: MyColors().PRIMARY_TINT, shape: BoxShape.circle),
                child: new Icon(
                  Remix.external_link_line,
                  color: MyColors().PRIMARY,
                  size: 32,
                ),
              )
            ],
          ),
        ));
  }
}
