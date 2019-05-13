import 'dart:collection';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readitnews/models/StatusEvent.dart';
import 'package:readitnews/models/cnblogs/cnblogs_home_data.dart';
import 'package:readitnews/services/CnBlogServices.dart';
import 'package:readitnews/utils/LogUtil.dart';
import 'package:readitnews/utils/ObjectUtil.dart';
import 'package:readitnews/utils/String.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

class CnBlogBloc implements BlocBase {
  BehaviorSubject<StatusEvent> _commonListStatusEvent =
      BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get _commonListStatusSink => _commonListStatusEvent.sink;

  Stream<StatusEvent> get commonListStatusStream =>
      _commonListStatusEvent.stream.asBroadcastStream();

  ///****** ****** ****** CnBlog ****** ****** ****** /
  BehaviorSubject<String> _cnblogDetails = BehaviorSubject<String>();

  BehaviorSubject<List<CnBlogsSitehomeItem>> _cnblogHome =
      BehaviorSubject<List<CnBlogsSitehomeItem>>();

  Sink<List<CnBlogsSitehomeItem>> get _cnblogHomeSink => _cnblogHome.sink;

  Stream<List<CnBlogsSitehomeItem>> get cnblogHomeStream => _cnblogHome.stream;

  List<CnBlogsSitehomeItem> _cnblogList;
  int _cnblogPage = 0;

  Future getCnBlogHomeData(String labelId, int page) {
    return CnBlogServices.getSiteHomeData(page).then((list) {
      if (_cnblogList == null) {
        _cnblogList = new List();
      }
      if (page == 0) {
        _cnblogList.clear();
      }
      _cnblogList.addAll(list);
      _cnblogHomeSink
          .add(UnmodifiableListView<CnBlogsSitehomeItem>(_cnblogList));
      _commonListStatusSink.add(new StatusEvent(
          labelId,
          RefreshStatus.completed,
          ObjectUtil.isEmpty(list) ? LoadStatus.noMore : LoadStatus.idle));
    }).catchError((_) {
      _cnblogPage--;
      _commonListStatusSink
          .add(new StatusEvent(labelId, RefreshStatus.failed, LoadStatus.idle));
    });
  }

  ///****** ****** ****** CnBlog ****** ****** ****** /

  @override
  void dispose() {
    _cnblogHome.close();
    // TODO: implement dispose
  }

  @override
  Future getData({String labelId, int page}) {
    switch (labelId) {
      case Ids.cnBlog_home:
        return getCnBlogHomeData(labelId, page);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    switch (labelId) {
      case Ids.cnBlog_home:
        _page = ++_cnblogPage;
        break;
      default:
        break;
    }
    LogUtil.e("onLoadMore labelId: $labelId" + "   _page: $_page");
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({String labelId}) {
    switch (labelId) {
      case Ids.cnBlog_home:
        _cnblogPage = 0;
        break;
      default:
        break;
    }
    LogUtil.e("onRefresh labelId: $labelId");
    return getData(labelId: labelId, page: 0);
  }
}
