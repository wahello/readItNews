import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readitnews/bloc/bloc_juejin.dart';
import 'package:readitnews/bloc/bloc_provider.dart';
import 'package:readitnews/components/RefreshScaffold.dart';
import 'package:readitnews/components/flutter_radial_menu/src/radial_menu.dart';
import 'package:readitnews/components/flutter_radial_menu/src/radial_menu_item.dart';
import 'package:readitnews/models/juejin/listresult.dart';
import 'package:readitnews/utils/LogUtil.dart';
import 'package:rxdart/rxdart.dart';

import 'HomeItem.dart';

bool isInit = true;

class JuejinHomePage extends StatelessWidget {
  const JuejinHomePage({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    LogUtil.e("JuejinHomePage build......");
    RefreshController _controller = new RefreshController();
    final JuejinBloc bloc = BlocProvider.of<JuejinBloc>(context);
    bloc.commonListStatusStream.listen((event) {
      //if (labelId == event.labelId) {
      if (event.status == RefreshStatus.failed) {
        _controller.refreshFailed();
        return;
      }
      if (event.loading == LoadStatus.idle) {
        _controller.loadComplete();
      } else if (event.loading == LoadStatus.noMore) {
        _controller.loadNoData();
      }
      // }
    });

    if (isInit) {
      isInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId, category: JuejinCategory.Recommend);
      });
    }
    return new StreamBuilder(
      stream: bloc.juejinStream,
      builder: (BuildContext context, AsyncSnapshot<ListData> snapshot) {
        return new Scaffold(
          // floatingActionButton: new FloatingActionButton(
          //   child: new RadialMenu(
          //     items: <RadialMenuItem<int>>[
          //       const RadialMenuItem<int>(
          //         value: 1,
          //         child: const Icon(Icons.add),
          //       ),
          //       const RadialMenuItem<int>(
          //         value: -1,
          //         child: const Icon(Icons.remove),
          //       )
          //     ],
          //     radius: 100.0,
          //     onSelected: print,
          //   ),
          // ),
          body: new Stack(
            children: [
              new RefreshScaffold(
                labelId: labelId,
                isLoading: snapshot.data == null,
                controller: _controller,
                onRefresh: () {
                  return bloc.onRefresh(
                      labelId: labelId, category: JuejinCategory.Recommend);
                },
                onLoadMore: () {
                  bloc.onLoadMore(
                      labelId: labelId, category: JuejinCategory.Recommend);
                },
                itemCount:
                    snapshot.data == null ? 0 : snapshot.data.list.length,
                itemBuilder: (BuildContext context, int index) {
                  Edges model = snapshot.data.list[index];
                  return new HomeItem(model: model);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
