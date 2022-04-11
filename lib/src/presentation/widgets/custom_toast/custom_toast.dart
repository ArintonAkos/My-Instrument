import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:line_icons/line_icons.dart';

enum ToastType {
  info,
  error,
  warning,
  success
}

Color _getColorByType(ToastType type) {
  switch (type) {
    case ToastType.warning:
      return const Color(0xFFFAAD14);
    case ToastType.info:
      return const Color(0xFF0065FF);
    case ToastType.error:
      return const Color(0xFFF5222D);
    case ToastType.success:
      return const Color(0xFF52C41A);
  }
}

IconData _getIconByType(ToastType type) {
  switch (type) {
    case ToastType.info:
      return LineIcons.infoCircle;
    case ToastType.error:
      return LineIcons.exclamation;
    case ToastType.warning:
      return LineIcons.exclamationTriangle;
    case ToastType.success:
      return LineIcons.checkCircle;
  }
}

Widget _getToast(ToastType type, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: _getColorByType(type)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  _getIconByType(type),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    ),
  );
}

void showCustomToast(ToastType type, String text) {
  showToastWidget(_getToast(type, text),
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    duration: const Duration(seconds: 4)
  );
}