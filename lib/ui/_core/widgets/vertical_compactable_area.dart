import 'package:flutter/material.dart';

import '../dimensions.dart';

class VerticalCompactableArea extends StatefulWidget {
  final Widget title;
  final Widget child;
  final List<Widget>? actions;
  final double width;
  final double heightPercentage;
  final Function? onExpand;

  const VerticalCompactableArea({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.width = 250,
    this.heightPercentage = 0.8,
    this.onExpand,
  });

  @override
  State<VerticalCompactableArea> createState() =>
      _VerticalCompactableAreaState();
}

class _VerticalCompactableAreaState extends State<VerticalCompactableArea> {
  bool isExpanded = false;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onEnter: (event) => setState(() {
            isHovering = true;
          }),
          onExit: (event) => setState(() {
            isHovering = false;
          }),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 750),
            curve: Curves.ease,
            opacity: (isExpanded || isHovering) ? 1 : 0.33,
            child: Container(
              width: widget.width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.title,
                  Row(
                    children: [
                      if (widget.actions != null)
                        Row(children: widget.actions!),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                          if (isExpanded) {
                            if (widget.onExpand != null) {
                              widget.onExpand!();
                            }
                          }
                        },
                        icon: Icon(isExpanded
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: widget.width,
          height: isExpanded ? height(context) * widget.heightPercentage : 0,
          curve: Curves.ease,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).textTheme.bodyMedium!.color!),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: (isExpanded) ? widget.child : null,
        ),
      ],
    );
  }
}
