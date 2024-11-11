import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedSearchBar extends StatefulWidget {
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final Function onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;

  const AnimatedSearchBar({
    super.key,
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",
    this.animationDurationInMilli = 375,
    this.color = const Color(0xFF292726),
    this.textFieldColor = const Color(0xFF292726),
    this.searchIconColor = Colors.white,
    this.textFieldIconColor = Colors.white,
    this.textInputAction = TextInputAction.done,
    required this.onSuffixTap,
    required this.onSubmitted,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.boxShadow = true,
    this.inputFormatters,
    required this.searchBarOpen,
  });

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  FocusNode focusNode = FocusNode();
  int toggle = 0;
  String textFieldValue = '';

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  void unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust dimensions based on screen size
    final dynamicWidth = screenWidth * 0.78;
    final dynamicHeight = screenHeight * 0.045;

    return Container(
      height: dynamicHeight, // Responsive height
      alignment: widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: dynamicHeight, // Responsive height
        width: (toggle == 0) ? 40.0 : dynamicWidth, // Responsive width
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: toggle == 1 ? widget.textFieldColor : widget.color,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: !widget.boxShadow
              ? null
              : [
                  const BoxShadow(
                    color: Colors.black,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 2.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 1.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                    child: GestureDetector(
                      onTap: () {
                        widget.onSuffixTap();
                        if (textFieldValue == '') {
                          unfocusKeyboard();
                          setState(() {
                            toggle = 0;
                          });
                          _con.reverse();
                        }
                        widget.textController.clear();
                        textFieldValue = '';
                        if (widget.closeSearchOnSuffixTap) {
                          unfocusKeyboard();
                          setState(() {
                            toggle = 0;
                          });
                        }
                      },
                      child: widget.suffixIcon != null
                          ? widget.suffixIcon
                          : const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.0,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,

              // Make 'top' responsive based on screen height
              top: screenHeight * 0.009, // Adjust the percentage based on your needs

              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: dynamicWidth / 1.7, // Responsive text field width
                  
                  child: TextField(
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    textInputAction: widget.textInputAction,
                    cursorRadius: const Radius.circular(10.0),
                    cursorWidth: 2.0,
                    cursorHeight: dynamicHeight * 0.5,
                    onChanged: (value) {
                      textFieldValue = value;
                    },
                    onSubmitted: (value) {
                      widget.onSubmitted(value);
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                      widget.textController.clear();
                    },
                    onEditingComplete: () {
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },
                    style: widget.style ?? const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    
                    // Vertically centering the text with proper contentPadding
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0), // Adjust padding here
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: GoogleFonts.poppins(
  color: const Color(0xff5B5B5B),
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                       // Remove black line
                      
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: toggle == 0 ? widget.color : widget.textFieldColor,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(() {
                    if (toggle == 0) {
                      toggle = 1;
                      if (widget.autoFocus) {
                        FocusScope.of(context).requestFocus(focusNode);
                      }
                      _con.forward();
                    } else {
                      toggle = 0;
                      if (widget.autoFocus) unfocusKeyboard();
                      _con.reverse();
                    }
                  });
                  widget.searchBarOpen(toggle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
