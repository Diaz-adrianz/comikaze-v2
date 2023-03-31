import 'package:flutter/material.dart';
import 'package:mobile/services/auth.dart';

// mine
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';
import 'package:mobile/components/input.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/inputicon.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double height(BuildContext context) => MediaQuery.of(context).size.height;
  double width(BuildContext context) => MediaQuery.of(context).size.width;

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();

  bool _isLoading = false;

  void _handleLogin(BuildContext ctx) async {
    setState(() {
      _isLoading = true;
    });

    var call = AuthCall(
        ctx, 'account/login', {"phone": _phone.text, "code": _code.text}, true);

    await call.post(call.login());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().PRIMARY,
      body: Center(
          child: Container(
        width: width(context) * 0.8,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: MyColors().WHITE, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "WELCOME!",
                  style: MyTexts().header,
                ),
                _isLoading
                    ? Container(
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
            Container(
                margin: const EdgeInsets.only(top: 24),
                child: InputIcon(
                    _phone, (value) {}, 'Nomor telepon', Remix.phone_fill)

                //  TextField(
                //     controller: _phone,
                //     cursorColor: MyColors().PRIMARY,
                //     style: MyTexts().text,
                //     decoration: MyInput().basic("08.."))
                ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                child:
                    InputIcon(_code, (value) {}, 'Kode akses', Remix.key_fill)),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        _handleLogin(context);
                      },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: MyColors().PRIMARY,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text(
                  "Lanjut",
                  style: MyTexts().subheader_w,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Belum punya? ",
                    style: MyTexts().mini_text,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await launch('https://forms.gle/D6UA5DbB4L98adXi9',
                          forceWebView: false)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'URL tidak bisa dibuka',
                              style: MyTexts().mini_text_w,
                            )));
                      }
                    },
                    child: Text("Daftar", style: MyTexts().mini_text_p),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
