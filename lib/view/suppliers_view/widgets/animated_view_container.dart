import 'package:flutter/material.dart';
import 'package:supply_link/theme/constants.dart';

class AnimatedViewContainer extends StatefulWidget {
  Map viewElement;

  AnimatedViewContainer({super.key, required this.viewElement});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedViewContainerState createState() => _AnimatedViewContainerState();
}

class _AnimatedViewContainerState extends State<AnimatedViewContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Map viewElement = {};

  @override
  void initState() {
    super.initState();
    viewElement = widget.viewElement;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          width: MediaQuery.of(context).size.width * _animation.value,
          decoration: BoxDecoration(
            gradient: Constant.whiteLinearGradient,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROij5P-V154Z5yp2_SKls91iaOjkTF6o3N34N7awDy6g&s'),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${viewElement['name']}', style: Constant.headline1),
                      Text('${viewElement['location'] ?? viewElement['email']}',
                          style: Constant.headline2),
                      Text(
                          '${viewElement['contactNumber'] ?? viewElement['phoneNumber']}',
                          style: Constant.headline3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
