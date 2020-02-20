import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/core/widgets/responsiveness.dart';
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
        return StreamBuilder<String>(
            stream: _bloc.errorMessage.stream,
            builder: (_, AsyncSnapshot<String> errorShot) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(context, 18),
                    vertical: responsiveHeight(context, 15)),
                child: TextField(
                  onChanged: _bloc.query.sink,
                  controller: _bloc.controller,
                  onSubmitted: (String value) =>
                      _bloc.listenToMovieQueries(context, value),
                  decoration: InputDecoration(
                    errorText: errorShot.data,
                    hintText: 'Pesquisar...',
                    suffix: GestureDetector(
                      onTap: () => _bloc.clearTextField(context),
                      child: Icon(Icons.delete),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () =>
                          _bloc.listenToMovieQueries(context, snapshot.data),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                  ),
                ),
              );
            });
      },
    );
  }
}
