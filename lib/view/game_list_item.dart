import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozgalica/model/game_model.dart';
import 'package:mozgalica/service/localization_service.dart';

class GameListItem extends StatelessWidget {
  const GameListItem({super.key, required this.game, required this.onTap});

  final GameModel game;
  final Function onTap;
// icon, name, description and reaction on tap

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      radius: 16,
      child: Padding(
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
                child: SvgPicture.asset(
                  game.svgIconPath,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    GameLocalizationService.getLocalizedTitle(context, game),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      GameLocalizationService.getLocalizedDescription(
                        context,
                        game,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
