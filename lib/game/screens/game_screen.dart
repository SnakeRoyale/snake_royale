import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaake/game/screens/game_over_screen.dart';

import '../blocs/game_bloc.dart';
import '../blocs/game_events.dart';
import '../blocs/game_state.dart';
import '../models/board.dart';
import '../models/status.dart';
import '../renderer/game_renderer.dart';
import '../widgets/loading_widget.dart';
import '../widgets/pause_widget.dart';

/// Main game screen.
class GameScreen extends StatelessWidget {
  /// Conveninent constructor.
  GameScreen({
    Key key,
  }) : super(key: key);

  final FocusNode _focusNode = FocusNode();

  Rect _getScreenSize(BuildContext context, double appBarHeight) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final topPadding = mediaQuery.padding.top;

    return Rect.fromLTWH(
      mediaQuery.padding.left,
      appBarHeight + topPadding,
      width - mediaQuery.padding.right,
      height - appBarHeight - topPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GameBloc>(context);

    final screen = _getScreenSize(context, 0);

    final tileSize = screen.width / 30;

    final board = Board(
      screen.width ~/ tileSize,
      screen.height ~/ tileSize,
    );

    final _gameRenderer = GameRenderer(
      tileSize: tileSize,
      screen: screen,
      board: board,
    );

    bloc.add(OnBoardCreatedEvent(board));

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0.0) {
            bloc.add(OnKeyPressedEvent(LogicalKeyboardKey.arrowRight));
          } else {
            bloc.add(OnKeyPressedEvent(LogicalKeyboardKey.arrowLeft));
          }
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0.0) {
            bloc.add(OnKeyPressedEvent(LogicalKeyboardKey.arrowDown));
          } else {
            bloc.add(OnKeyPressedEvent(LogicalKeyboardKey.arrowUp));
          }
        },
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (event) {
            bloc.add(OnKeyPressedEvent(event.logicalKey));
          },
          child: BlocListener<GameBloc, GameState>(
            listener: (context, state) {
              _gameRenderer.updateFood(state.food);
              _gameRenderer.updateSnake(state.snake);
            },
            child: BlocBuilder<GameBloc, GameState>(
              condition: (before, current) => before.status != current.status,
              builder: (context, state) {
                final bloc = BlocProvider.of<GameBloc>(context);

                switch (state.status) {
                  case Status.loading:
                    return LoadingWidget();
                    break;
                  case Status.pause:
                    return Stack(children: <Widget>[
                      _gameRenderer.widget,
                      if (state.status == Status.pause)
                        PauseWidget(
                          text: 'Tap to resume',
                          onTap: () => bloc.add(ResumeGameEvent()),
                        ),
                    ]);
                    break;
                  case Status.gameOver:
                    return GameOverScreen(won: false);
                    break;
                  default:
                    return _gameRenderer.widget;
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
