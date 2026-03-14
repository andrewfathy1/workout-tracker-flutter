import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xFF0F1115),
      ),
    );

    // return Hero(
    //   tag: 'bg',
    //   child: Transform.flip(
    //     flipY: true,
    //     flipX: true,
    //     child: Container(
    //       height: heightPercentage,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage('assets/images/bg.jpg'),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
