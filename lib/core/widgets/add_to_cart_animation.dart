import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const AddToCartButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    _controller.forward();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.iconColor ?? Theme.of(context).primaryColor;
    final backgroundColor = widget.backgroundColor ?? Colors.white;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _handlePress,
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: iconColor,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 20,
              ),
            ),
          ),
        );
      },
    );
  }
} 