import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/config/appConfig.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/provider/provider_setup.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/util/image/local_image_selector.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/view_model/base/locale_model.dart';
import 'package:my_network_encapsulation/view_model/base/theme_data_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.getInstance();
  SizeUtil.initialize();
  LocalImageSelector.init();

  //设置头部导航栏的透明
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //全局设置透明
      statusBarIconBrightness: Brightness.light
    //light:黑色图标 dark：白色图标
    //在此处设置statusBarIconBrightness为全局设置
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      // backgroundColor: Colors.grey,
      child: MultiProvider(
        providers: providers,
        child: Consumer2<LocaleModel,ThemeDataModel>(
          builder: (context, LocaleModel currentLocale,ThemeDataModel themeData, child) {
            // 统一刷新控件
            return RefreshConfiguration(
                hideFooterWhenNotFull: true, // Viewport不满一屏时,禁用上拉加载更多功能
                // headerBuilder: () => WaterDropHeader(),// 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
                // footerBuilder:  () => ClassicFooter(), // 配置默认底部指示器
                // headerTriggerDistance: 80.0,        // 头部触发刷新的越界距离
                // springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
                // maxOverScrollExtent :100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
                // maxUnderScrollExtent:0, // 底部最大可以拖动的范围
                // enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
                // enableLoadingWhenFailed : true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
                // enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
                child: MaterialApp(
                  // title: 'NetWork Demo',
                  theme: themeData.myThemeData, // 主题
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,   // 指定本地化的字符串和一些其他的值
                    GlobalCupertinoLocalizations.delegate,  // 对应的Cupertino风格
                    GlobalWidgetsLocalizations.delegate,    // 指定默认的文本排列方向，由左到右或由右到左
                  ],
                  locale: currentLocale.locale, // 当前的语言
                  supportedLocales: S.delegate.supportedLocales, // 支持的语言
                  navigatorKey: AppConfig.globalKey,      // 全局globalKey
                  onGenerateRoute: MyRouter.generateRoute,  // 路由拦截器
                  initialRoute: routeName(),
                  // initialRoute: RouteName.privacyTipsPage,
                  builder: (context, widget) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: 1.0), // 字体大小不随系统变化
                      child: widget!,
                    );
                  },
                )
            );
          },
        ),
      ),
    );
  }

  //检测是否同意了隐私政策
  String routeName() {
    if(LocalStorage.get(Keys.agreePrivacy) == null || !LocalStorage.get(Keys.agreePrivacy)){
      return RouteName.privacyTipsPage;
    }else{
      return RouteName.startupPage;
    }
    print('123456');
  }
}
