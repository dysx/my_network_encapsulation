import 'package:my_network_encapsulation/viewModel/base/locale_model.dart';
import 'package:my_network_encapsulation/viewModel/base/theme_data_model.dart';
import 'package:my_network_encapsulation/viewModel/favourite_model.dart';
import 'package:my_network_encapsulation/viewModel/message/conversion.dart';
import 'package:my_network_encapsulation/viewModel/message/user.dart';
import 'package:my_network_encapsulation/viewModel/user_model.dart';
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
  ChangeNotifierProvider<ConversionModel>(create: (context) => ConversionModel()),
  ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
  ChangeNotifierProvider<ImUserModel>(create: (context) => ImUserModel()),
  ChangeNotifierProvider<GlobalFavouriteStateModel>(
    create: (context) => GlobalFavouriteStateModel(),
  )
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
