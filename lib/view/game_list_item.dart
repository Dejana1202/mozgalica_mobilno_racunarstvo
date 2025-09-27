import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameListItem extends StatelessWidget {
  const GameListItem({
    super.key,
    required this.title,
    required this.description,
    required this.onPlay,
    required this.svgIconPath,
  });

  final String title;
  final String description;
  final Function onPlay;
  final String svgIconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(svgIconPath, height: 100, width: 100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onPlay(),
                  child: const Text("PLAY"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
