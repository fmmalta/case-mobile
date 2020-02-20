import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/core/widgets/responsiveness.dart';

class NoMovieFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: deviceSize(context).height / 3,
          child: FlareActor(
            'flare/error-message.flr',
            animation: 'error-message',
          ),
        ),
        SizedBox(height: responsiveHeight(context, 20)),
        Text('Nenhum filme encontrado...')
      ],
    );
  }
}
