// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal/controller/content_controller.dart';
import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/responsive.dart';

class ContentUI extends StatefulWidget {
  const ContentUI({
    super.key,
  });
  @override
  _ContentUIState createState() => _ContentUIState();
}

class _ContentUIState extends State<ContentUI> {
  ContentController? _contentController;

  @override
  Widget build(BuildContext context) {
    _contentController = Provider.of<ContentController>(context);

    return ValueListenableBuilder<List<String>>(
        valueListenable: _contentController!.message,
        builder: (context, messages, child) {
          return Column(
            children: messages
                .map(
                  (e) => Container(
                    margin: EdgeInsets.fromLTRB(
                      !Responsive.isMobile(context)
                          ? Responsive.width(context) / 6
                          : 10,
                      20,
                      !Responsive.isMobile(context)
                          ? Responsive.width(context) / 6
                          : 10,
                      0,
                    ),
                    width: double.infinity,
                    // height: 20,
                    child: SelectableText(
                      e,
                      style: TextStyle(
                        fontSize: SystemController.fontSize,
                        color: e.startsWith(SystemController.user!)
                            ? SystemController.fontColor
                            : Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        });
  }
}
