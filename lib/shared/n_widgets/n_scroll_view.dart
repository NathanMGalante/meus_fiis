import 'package:flutter/material.dart';

class NScrollView extends StatefulWidget {
  const NScrollView({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
  });

  final Widget child;

  final Axis scrollDirection;

  @override
  State<NScrollView> createState() => _NScrollViewState();
}

class _NScrollViewState extends State<NScrollView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFadeLeft = false;
  bool _showFadeRight = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _showFadeLeft = _scrollController.offset > 0;
        _showFadeRight = _scrollController.offset <
            _scrollController.position.maxScrollExtent;
      });
    });
    _scrollController.addListener(() {
      setState(() {
        _showFadeLeft = _scrollController.offset > 0;
        _showFadeRight = _scrollController.offset <
            _scrollController.position.maxScrollExtent;
      });
    });
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
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        child: widget.child,
      ),
    );
  }
}
