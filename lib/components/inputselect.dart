import 'package:flutter/material.dart';
import 'package:mobile/models/genres.dart';
import 'package:remixicon/remixicon.dart';

// MY STTLES
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';

Widget InputSelect(BuildContext ctx, Genre selected,
    ValueChanged<Genre> selectedCtrl, List<Genre> items) {
  TextEditingController _ctrl = TextEditingController();
  _ctrl.text = selected.genreName.toString();

  return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: ctx,
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
                builder: (context, scrollController) {
                  return Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              width: 100,
                              height: 8,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  color: MyColors().SECONDARY,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          Expanded(
                              child: ListView(
                            controller: scrollController,
                            shrinkWrap: true,
                            children: [
                              for (Genre item in items)
                                GestureDetector(
                                  onTap: () {
                                    selectedCtrl(item);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    margin: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: MyColors().SILVER))),
                                    child: Text(
                                      item.endpoint.toString(),
                                      style: MyTexts().subheader,
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
      child: IntrinsicWidth(
        child: TextField(
          enabled: false,
          controller: _ctrl,
          style: MyTexts().text,
          decoration: InputDecoration(
              hintStyle: MyTexts().text,
              suffixIcon: Icon(
                Remix.arrow_down_s_line,
                color: MyColors().SECONDARY,
                size: 24,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors().PRIMARY),
                  borderRadius: BorderRadius.circular(16)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors().SECONDARY),
                  borderRadius: BorderRadius.circular(16))),
        ),
      ));
}
