// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal/controller/content_controller.dart';
import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/responsive.dart';
import 'package:terminal/util/image_util.dart';

class TerminalUI extends StatefulWidget {
  const TerminalUI({super.key});

  @override
  _TerminalUIState createState() => _TerminalUIState();
}

class _TerminalUIState extends State<TerminalUI> {
  final ScrollController _scrollController = ScrollController();

  late ContentController _contentController;

  final FocusNode _focusNode = FocusNode();

  late BoxDecoration _boxDecoration;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (SystemController.bgIsImg) {
      _boxDecoration = BoxDecoration(
        image: DecorationImage(
          image: ImageUtil.backgroundImage(SystemController.backgroundImage),
          fit: BoxFit.cover,
        ),
        color: SystemController.backgroundColor,
      );
    } else {
      _boxDecoration = BoxDecoration(
        color: SystemController.backgroundColor,
      );
    }
    _contentController = Provider.of<ContentController>(
      context,
      listen: false,
    );

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        decoration: _boxDecoration,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 10),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: SystemController.blur, sigmaY: SystemController.blur),
          child: Container(
            color: Color.fromARGB(SystemController.alpha, 0, 0, 0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Column(
                    children: _contentController.message
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
                                color: e.startsWith(SystemController.user)
                                    ? SystemController.fontColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    width: double.infinity,
                    // height: 20,
                    margin: EdgeInsets.fromLTRB(
                      !Responsive.isMobile(context)
                          ? Responsive.width(context) / 6
                          : 10,
                      10,
                      !Responsive.isMobile(context)
                          ? Responsive.width(context) / 6
                          : 10,
                      10,
                    ),
                    child: RawKeyboardListener(
                      onKey: (value) {
                        tabHandle(value);
                      },
                      focusNode: FocusNode(),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: _contentController.hintMessage,
                              hintStyle: TextStyle(
                                fontSize: SystemController.fontSize,
                                color: Colors.grey,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.fromLTRB(
                                  SystemController.fontSize * 4 + 4, 0, 20, 0),
                            ),
                            minLines: 1,
                          ),
                          TextField(
                            focusNode: _focusNode,
                            autofocus: true,
                            controller: _contentController.editingController,
                            onEditingComplete: () => excuteOrder(),
                            onChanged: (value) => hint(value),
                            style: TextStyle(
                              fontSize: SystemController.fontSize,
                              color: SystemController.fontColor,
                            ),
                            decoration: InputDecoration(
                              icon: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 5.5),
                                child: SizedBox(
                                  width: SystemController.fontSize * 4,
                                  child: Text(
                                    SystemController.user,
                                    style: TextStyle(
                                      color: SystemController.fontColor,
                                      fontSize: SystemController.fontSize,
                                    ),
                                  ),
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(-12, 0, 20, 0),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            minLines: 1,
                            cursorWidth: 5,
                            cursorColor: Colors.yellowAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  excuteOrder() {
    String value = _contentController.editingController.text;
    List<String> messages = SystemController.baseOrderProvider.excute(value);
    setState(() {
      _contentController.message.addAll(messages);
      _contentController.editingController.clear();
    });
    _contentController.hintMessage = "";
    // 跳转最底部
    Future.delayed(const Duration(milliseconds: 50)).then(
      (value) =>
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );
  }

  void tabHandle(RawKeyEvent value) {
    _focusNode.requestFocus();
    switch (value.logicalKey.keyLabel) {
      case "Tab":
        if (_contentController.hintMessage.isNotEmpty) {
          setIr(_contentController.hintMessage);
        }
        break;
      case "Enter":
        setState(
          () {},
        );
        break;
      // case "Arrow Up":
      //   _contentController.tabOne = true;
      //   if (_contentController.index >= 0) {
      //     ir = _contentController.message[_contentController.index--];
      //     ir = ir.substring(ir.indexOf(" ") + 1);
      //   }
      //   setIr(ir);
      //   _contentController.tabOne = false;
      //   break;
      // case "Arrow Down":
      //   _contentController.tabOne = true;
      //   if (_contentController.index >= 0 &&
      //       _contentController.index < _contentController.message.length) {
      //     ir = _contentController.message[_contentController.index++];
      //     ir = ir.substring(ir.indexOf(" ") + 1);
      //   }
      //   setIr(ir);
      //   _contentController.tabOne = false;
      //   break;
    }
  }

  void setIr(String ir) {
    setState(
      () {
        _contentController.editingController.value = TextEditingValue(
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
    setState(() {
      _contentController.hintMessage = ir;
    });
  }
}
