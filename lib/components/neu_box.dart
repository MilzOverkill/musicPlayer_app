import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({
    super.key,
    required this.child
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow:[

          //darker shadow on the bottom right

          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4, 4), 
          ),

          //lighter shadow on the top left 

          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: const Offset(-4, -4), 
          ),
        ],
      ),

      padding: const EdgeInsets.all(12),
      child: child,

    );
  }
}
