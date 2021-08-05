import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_news/cubit/cubit.dart';
import 'package:flutter_application_news/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../const.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NewsCubit>(context);

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return ConditionalBuilder(
          fallback: (ctx) => Center(
            child: CircularProgressIndicator(),
          ),
          condition: cubit.sports.length > 0,
          builder: (context) => ListView.separated(
            separatorBuilder: (ctx, index) {
              return divider();
            },
            itemBuilder: (context, i) {
              return articleItem(context, cubit, i, cubit.sports);
            },
            itemCount: countArticles(cubit, cubit.sports),
          ),
        );
      },
    );
  }
}
