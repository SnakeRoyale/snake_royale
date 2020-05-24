import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/game_bloc.dart';
import '../blocs/game_events.dart';
import '../blocs/game_state.dart';
import '../models/board.dart';
import '../models/status.dart';
import '../renderer/game_renderer.dart';
import '../widgets/loading_widget.dart';
import 'game_over_screen.dart';

/// Main game screen.
class GameScreen extends StatelessWidget {
  /// Conveninent constructor.
  GameScreen({
    Key key,
  }) : super(key: key);

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GameBloc>(context);

    final mq = MediaQuery.of(context);
    final screen = Rect.fromLTWH(0, 0, mq.size.width, mq.size.height);

    final tileSize = screen.width / 30;

    final board = Board(
      screen.width ~/ tileSize,
      screen.height ~/ tileSize,
    );

    final maxSnakeLength = board.height * board.width - bloc.snakeInitialLength;

    final _gameRenderer = GameRenderer(
      tileSize: tileSize,
      screen: screen,
      board: board,
    );

    bloc.add(OnBoardCreatedEvent(board));

    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
        child: SafeArea(
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
                  switch (state.status) {
                    case Status.loading:
                      return LoadingWidget();
                      break;
                    case Status.gameOver:
                      return GameOverScreen(
                        won: state.score >= maxSnakeLength,
                        score: state.score,
                      );
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
      ),
    );
  }
}
