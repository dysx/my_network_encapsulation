import 'package:my_network_encapsulation/provider/view_state_model.dart';
import 'package:my_network_encapsulation/util/cache_util.dart';

class CacheModel extends ViewStateModel {
  String cache = '';

  initCache() async {
    setBusy();
    cache = await CacheUtil.loadCache();
    setIdle();
  }

  clearCache() async {
    setBusy();
    await CacheUtil.clearCache();
    cache = await CacheUtil.loadCache();
    setIdle();
  }
}
