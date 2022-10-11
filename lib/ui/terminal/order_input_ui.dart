// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal/controller/content_controller.dart';
import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/provider/others/content_provider.dart';
import 'package:terminal/responsive.dart';
import 'package:terminal/ui/terminal/terminal.dart';

class OrderInputUI extends StatefulWidget {
  const OrderInputUI({super.key});

  @override
  _OrderInputUIState createState() => _OrderInputUIState();
}

class _OrderInputUIState extends State<OrderInputUI> {
  ContentController? _contentController;

  @override
  Widget build(BuildContext context) {
    _contentController = Provider.of<ContentController>(
      context,
      listen: false,
    );

    return Container(
      width: double.infinity,
      // height: 20,
      margin: EdgeInsets.fromLTRB(
        !Responsive.isMobile(context) ? Responsive.width(context) / 6 : 10,
        10,
        !Responsive.isMobile(context) ? Responsive.width(context) / 6 : 10,
        10,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ValueListenableBuilder<String>(
              valueListenable: _contentController!.hintMessage,
              builder: (context, hintMsg, child) {
                return TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: hintMsg,
                    hintStyle: TextStyle(
                      fontSize: SystemController.fontSize,
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(
                        SystemController.fontSize! * 4 + 4, 0, 20, 0),
                  ),
                  minLines: 1,
                );
              }),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
              width: SystemController.fontSize! * 4,
              child: Text(
                SystemController.user!,
                style: TextStyle(
                  color: SystemController.fontColor,
                  fontSize: SystemController.fontSize,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: RawKeyboardListener(
              onKey: (value) {
                tabHandle(value);
              },
              focusNode: FocusNode(),
              child: TextField(
                focusNode: Terminal.focusNode,
                autofocus: true,
                controller: _contentController!.editingController,
                onEditingComplete: () => excuteOrder(),
                onChanged: (value) => hint(value),
                style: TextStyle(
                  fontSize: SystemController.fontSize,
                  color: SystemController.fontColor,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                      SystemController.fontSize! * 4 + 4, 0, 20, 0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                minLines: 1,
                cursorWidth: 5,
                cursorColor: Colors.yellowAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  excuteOrder() {
    String value = _contentController!.editingController.text;
    List<String> messages = SystemController.baseOrderProvider.excute(value);
    ContentProvider.addAll(messages);

    ContentProvider.clearText();
    ContentProvider.clearHintText();
    // 跳转最底部
    Future.delayed(const Duration(milliseconds: 20)).then((value) {
      Terminal.scrollController
          .jumpTo(Terminal.scrollController.position.maxScrollExtent);
    });
  }

  void tabHandle(RawKeyEvent value) {
    Terminal.focusNode.requestFocus();
    switch (value.logicalKey.keyLabel) {
      case "Tab":
        if (_contentController!.hintMessage.value.isNotEmpty) {
          setIr(_contentController!.hintMessage.value);
        }
        break;
      case "Enter":
        break;
    }
  }

  void setIr(String ir) {
    setState(
      () {
        _contentController!.editingController.value = TextEditingValue(
          text: ir,
          selection: TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: ir.length,
            ),
          ),
        );
      },
    );
  }

  void hint(String value) {
    String ir = SystemController.baseOrderProvider.orderTab(value);
    _contentController!.hintMessage.value = ir;
  }
}
