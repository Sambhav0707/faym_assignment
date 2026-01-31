import 'package:flutter/material.dart';

class SwipeButton extends StatefulWidget {
  final VoidCallback onSwipe;
  final String text;
  final bool enabled;

  const SwipeButton({
    super.key,
    required this.onSwipe,
    this.text = 'Swipe to Confirm',
    this.enabled = true,
  });

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton>
    with SingleTickerProviderStateMixin {
  double _dragValue = 0.0;
  static const double _height = 56.0;
  static const double _padding = 4.0;
  static const double _knobSize = _height - _padding * 2;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details, double width) {
    if (!widget.enabled) return;
    setState(() {
      _dragValue = (_dragValue + details.delta.dx).clamp(
        0.0,
        width - _knobSize - _padding * 2,
      );
    });
  }

  void _onDragEnd(DragEndDetails details, double width) {
    if (!widget.enabled) return;
    final maxDrag = width - _knobSize - _padding * 2;
    if (_dragValue > maxDrag * 0.9) {
      // Swipe completed
      widget.onSwipe();
      // Snap back animation
      _animateToZero();
    } else {
      // Snap back
      _animateToZero();
    }
  }

  void _animateToZero() {
    _animation = Tween<double>(
      begin: _dragValue,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward(from: 0).then((_) {
      setState(() {
        _dragValue = 0.0;
      });
    });
    _controller.addListener(() {
      setState(() {
        _dragValue = _animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: _height,
              decoration: BoxDecoration(
                color: widget.enabled
                    ? const Color(0xFF1E1E1E)
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(_height / 2),
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.enabled
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              left: _padding + _dragValue,
              top: _padding,
              child: GestureDetector(
                onHorizontalDragUpdate: (d) =>
                    _onDragUpdate(d, constraints.maxWidth),
                onHorizontalDragEnd: (d) => _onDragEnd(d, constraints.maxWidth),
                child: Container(
                  width: _knobSize,
                  height: _knobSize,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: widget.enabled ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
