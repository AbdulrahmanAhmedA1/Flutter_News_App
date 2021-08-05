import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_news/cubit/cubit.dart';
import 'package:flutter_application_news/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../const.dart';

class ScienceScreen extends StatelessWidget {
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
          condition: cubit.science.length > 0,
          builder: (ctx) => ListView.separated(
            separatorBuilder: (ctx, i) {
              return divider();
            },
            itemBuilder: (context, index) {
              return articleItem(context, cubit, index, cubit.science);
            },
            itemCount: countArticles(cubit, cubit.science),
          ),
        );
      },
    );
  }

}
