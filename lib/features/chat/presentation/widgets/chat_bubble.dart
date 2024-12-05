import 'package:flutter/material.dart';
import 'package:gamer_tag/common/extensions.dart';
import 'package:gamer_tag/features/chat/domain/message.dart';

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final Message message;
  final bool tail;
  final Animation<double> animation;
  final VoidCallback? onDelete;

  const ChatBubble({
    super.key,
    this.isSender = true,
    required this.message,
    required this.animation,
    this.onDelete,
    this.tail = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Dismissible(
        direction:
            isSender ? DismissDirection.endToStart : DismissDirection.none,
        key: Key('${message.hashCode}'),
        onDismissed: (direction) => onDelete?.call(),
        child: Align(
          alignment: isSender ? Alignment.topRight : Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: CustomPaint(
              painter: SpecialChatBubbleThree(
                  color: message.durationInSecond != null
                      ? context.colors.tertiaryContainer
                      : isSender
                          ? context.colors.primaryContainer
                          : context.colors.secondaryContainer,
                  alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                  tail: tail),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7,
                ),
                margin: isSender
                    ? const EdgeInsets.fromLTRB(7, 7, 17, 7)
                    : const EdgeInsets.fromLTRB(17, 7, 7, 7),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Text(
                        message.text,
                        textAlign: TextAlign.left,
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: isSender ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialChatBubbleThree extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  SpecialChatBubbleThree({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    if (alignment == Alignment.topRight) {
      if (tail) {
        var path = Path();

        path.moveTo(_radius * 2, 0);
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);
        path.lineTo(0, h - _radius * 1.5);
        path.quadraticBezierTo(0, h, _radius * 2, h);
        path.lineTo(w - _radius * 3, h);
        path.quadraticBezierTo(
            w - _radius * 1.5, h, w - _radius * 1.5, h - _radius * 0.6);
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        path.quadraticBezierTo(
            w - _radius * 0.8, h, w - _radius, h - _radius * 1.5);
        path.lineTo(w - _radius, _radius * 1.5);

        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        path.moveTo(_radius * 2, 0);
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);
        path.lineTo(0, h - _radius * 1.5);
        path.quadraticBezierTo(0, h, _radius * 2, h);
        path.lineTo(w - _radius * 3, h);
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);
        path.lineTo(w - _radius, _radius * 1.5);
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        var path = Path();
        path.moveTo(_radius * 3, 0);
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);
        path.lineTo(_radius, h - _radius * 1.5);
        path.quadraticBezierTo(_radius * .8, h, 0, h);
        path.quadraticBezierTo(
            _radius * 1, h, _radius * 1.5, h - _radius * 0.6);
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);
        path.lineTo(w - _radius * 2, h);
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);
        path.lineTo(w, _radius * 1.5);
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();
        path.moveTo(_radius * 3, 0);
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);
        path.lineTo(_radius, h - _radius * 1.5);
        path.quadraticBezierTo(_radius, h, _radius * 3, h);
        path.lineTo(w - _radius * 2, h);
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);
        path.lineTo(w, _radius * 1.5);
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
