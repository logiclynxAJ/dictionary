import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar getAppBar(BuildContext context, TextTheme textTheme,
    {List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    leadingWidth: 250,
    elevation: 0,
    leading: Row(
      children: [
        const SizedBox(width: 4),
        InkWell(
          onTap: context.pop,
          radius: 16,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios_new, size: 30),
                Text('Search',
                    style: textTheme.headline6?.copyWith(color: Colors.black)),
              ],
            ),
          ),
        ),
      ],
    ),
    actions: actions,
  );
}
