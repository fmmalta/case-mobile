import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/bloc.dart';
import 'package:vitta_case_mobile/features/movies/presentation/widgets/home_page_widgets/search_text_field.dart';
import 'package:vitta_case_mobile/features/movies/presentation/widgets/home_page_widgets/searched_movies_result.dart';
import 'package:vitta_case_mobile/injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc;

  @override
  void initState() {
    _bloc = sl<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocBuilder: () => _bloc,
      blocDispose: (_) => _bloc?.dispose(),
      child: Scaffold(
        appBar: AppBar(title: Text('Filmes')),
        body: Column(
          children: <Widget>[
            SearchTextField(bloc: _bloc),
            SearchedMoviesResult(bloc: _bloc)
          ],
        ),
      ),
    );
  }
}
