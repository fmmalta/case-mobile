import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/home_bloc/home_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key key,
    @required HomeBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

  final HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      initialData: '',
      stream: _bloc.query.stream,
      builder: (_, AsyncSnapshot<String> snapshot) {
        return TextField(onChanged: _bloc.query.sink);
      },
    );
  }
}
