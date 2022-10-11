// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/ui/terminal/content_ui.dart';
import 'package:terminal/ui/terminal/order_input_ui.dart';
import 'package:terminal/ui/terminal/terminal.dart';
import 'package:terminal/util/image_util.dart';

class TerminalUI extends StatefulWidget {
  const TerminalUI({super.key});

  @override
  _TerminalUIState createState() => _TerminalUIState();
}

class _TerminalUIState extends State<TerminalUI> {
  BoxDecoration? _boxDecoration;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (SystemController.bgIsImg!) {
      _boxDecoration = BoxDecoration(
        image: DecorationImage(
          image: ImageUtil.backgroundImage(SystemController.backgroundImage!),
          fit: BoxFit.cover,
        ),
        color: SystemController.backgroundColor,
      );
    } else {
      _boxDecoration = BoxDecoration(
        color: SystemController.backgroundColor,
      );
    }

    return GestureDetector(
      onTap: () => Terminal.focusNode.requestFocus(),
      child: Container(
        decoration: _boxDecoration,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: SystemController.blur!, sigmaY: SystemController.blur!),
          child: Container(
            color: Color.fromARGB(SystemController.alpha!, 0, 0, 0),
            child: SingleChildScrollView(
              controller: Terminal.scrollController,
              child: Column(
                children: const [
                  ContentUI(),
                  OrderInputUI(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
