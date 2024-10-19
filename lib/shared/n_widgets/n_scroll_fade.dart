import 'package:flutter/material.dart';

class NScrollFade extends StatefulWidget {
  const NScrollFade({
    super.key,
    required this.controller,
    this.scrollDirection = Axis.vertical,
    required this.child,
  });

  final ScrollController controller;
  final Axis scrollDirection;
  final Widget child;

  @override
  State<NScrollFade> createState() => _NScrollFadeState();
}

class _NScrollFadeState extends State<NScrollFade> {
  bool _showFadeLeft = false;
  bool _showFadeRight = false;

  void _listener() {
    setState(() {
      _showFadeLeft = widget.controller.offset > 0;
      _showFadeRight = widget.controller.offset <
          widget.controller.position.maxScrollExtent;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _showFadeLeft = widget.controller.offset > 0;
        _showFadeRight = widget.controller.offset <
            widget.controller.position.maxScrollExtent;
      });
    });
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: widget.scrollDirection == Axis.horizontal
              ? Alignment.centerLeft
              : Alignment.topCenter,
          end: widget.scrollDirection == Axis.horizontal
              ? Alignment.centerRight
              : Alignment.bottomCenter,
          stops: const [0.0, 0.2, 0.8, 1.0],
          colors: [
            _showFadeLeft
                ? Colors.white.withOpacity(0.0)
                : Colors.white.withOpacity(1.0),
            Colors.white.withOpacity(1.0),
            Colors.white.withOpacity(1.0),
            _showFadeRight
                ? Colors.white.withOpacity(0.0)
                : Colors.white.withOpacity(1.0),
          ],
        ).createShader(rect);
      },
      child: widget.child,
    );
  }
}
