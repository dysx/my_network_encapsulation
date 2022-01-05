import 'package:my_network_encapsulation/view_model/base/locale_model.dart';
import 'package:my_network_encapsulation/view_model/base/theme_data_model.dart';
import 'package:my_network_encapsulation/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// @describe: 创建Provider服务配置列表
/// @author: qds
/// @date:

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ThemeDataModel>(create: (context) => ThemeDataModel()),
  ChangeNotifierProvider<LocaleModel>(create: (context) => LocaleModel()),
  ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
  // ChangeNotifierProvider<GlobalFavouriteStateModel>(
  //   create: (context) => GlobalFavouriteStateModel(),
  // )
];

/// 需要依赖的model
/// 例: UserModel依赖globalFavouriteStateModel
List<SingleChildWidget> dependentServices = [
  //这里使用ProxyProvider来定义需要依赖其他Provider的服务
  // ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
  //   create: null,
  //   update: (context, globalFavouriteStateModel, userModel) =>
  //       userModel ??
  //       UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
  // )
];

List<SingleChildWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
