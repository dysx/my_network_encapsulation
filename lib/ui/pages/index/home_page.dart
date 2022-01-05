import 'dart:io';

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/util/extension/widget.dart';
import 'package:my_network_encapsulation/util/pack/env_config.dart';
import 'package:my_network_encapsulation/util/permission_manager.dart';
import 'package:my_network_encapsulation/util/sort/bubble_sort.dart';
import 'package:my_network_encapsulation/util/sort/merge_sort.dart';
import 'package:my_network_encapsulation/util/sort/quick_sort.dart';
import 'package:my_network_encapsulation/view_model/base/locale_model.dart';
import 'package:my_network_encapsulation/view_model/base/theme_data_model.dart';
import 'package:dartx/dartx.dart';
import 'package:my_network_encapsulation/util/extension/file.dart';

/// @describe: bottomNavItem_first页面
/// @author: qds
/// @date:
// ignore: must_be_immutable
class HomePage extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => HomePageState();

  @override
  int setIndex() => 0;
}

class HomePageState extends BaseInnerWidgetState<HomePage> {
  int aaa = 0;

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 20,
            children: [
              ordinaryButton(
                  onPressed: () {
                    aaa += 1;
                    setState(() {});
                  },
                  text: '$aaa'),
              ordinaryButton(
                  onPressed: () {
                    LocalStorage.saveString(Keys.token, '123');
                    print("${LocalStorage.get(Keys.token)}");
                    RequestUtil.login('15015802692', 'qds123123',
                            cancelTag: 'HomePage')
                        .then((value) {
                      LocalStorage.saveString(
                          Keys.token, value.accessToken!);
                    });
                  },
                  text: '登陆'),
              ordinaryButton(
                  onPressed: () {
                    MyNavigator.pushNamed(RouteName.testA);
                  },
                  text: '获取列表'),
              ordinaryButton(
                  onPressed: () {
                    RequestUtil.getTime();
                  },
                  text: '获取时间'),
              ordinaryButton(
                  onPressed: () {
                    RequestUtil.getTime().then((value) {
                      print('请求结束,打印结果: ${value.sysTime2}');
                    });
                  },
                  text: '接口测试'),
              ordinaryButton(
                onPressed: () {
                  Provider.of<LocaleModel>(context, listen: false)
                      .switchLocale(1);
                },
                text: '设置中文',
              ),
              ordinaryButton(
                onPressed: () {
                  Provider.of<LocaleModel>(context, listen: false)
                      .switchLocale(2);
                },
                text: '设置英文',
              ),
              ordinaryButton(
                onPressed: () {
                  Provider.of<LocaleModel>(context, listen: false)
                      .switchLocale(0);
                },
                text: '跟随系统',
              ),
              ordinaryButton(
                onPressed: () {
                  // print(Provider.of<ThemeDataModel>(context).myThemeData);
                  Provider.of<ThemeDataModel>(context, listen: false)
                      .switchTheme(0);
                },
                text: '亮色主题',
              ),
              ordinaryButton(
                onPressed: () {
                  Provider.of<ThemeDataModel>(context, listen: false)
                      .switchTheme(1);
                },
                text: '护眼模式主题',
              ),
              ordinaryButton(
                onPressed: () {
                  LocalStorage.saveString(Keys.token, '123');
                },
                text: "存储token",
              ),
              ordinaryButton(
                onPressed: () {
                  Toast.showMsg(LocalStorage.get(Keys.token)!);
                  // Toast.showWidget(widget);
                },
                text: "打印token",
              ),
              ordinaryButton(
                onPressed: () {
                  LocalStorage.remove(Keys.token);
                },
                text: "清除token",
              ),
              ordinaryButton(
                onPressed: () {
                  MyNavigator.pushNamed(RouteName.testA);
                },
                text: "测试popUntil路由",
              ),
              ordinaryButton(
                  onPressed: () {
                    MyNavigator.pushNamed(RouteName.scrollToIndex);
                  },
                  text: "滑动到指定位置",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    // print(NavigatorManger.activityStack);
                    // Alert.showSheet(
                    //   barrierDismissible: true,
                    //   title: '标题',
                    //   actions: ['111','222']
                    // );
                    Alert.showAlert(title: '标题', message: '内容');
                  },
                  text: "打印路由",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    PermissionManager.applyStoragePermission(() {
                      print('申请权限成功');
                    });
                  },
                  text: "文件权限测试",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    Toast.showMsg(EnvConfig.CHANNEL);
                  },
                  text: "渠道",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    Toast.showMsg(EnvConfig.VERSION);
                  },
                  text: "版本",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    10.minutes;
                    final File fff = File('some/path/test.dart');
                    print(fff.fileName);
                    print(fff.fileNameWithoutExtension);
                  },
                  text: "文件名",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    List<int> ccc = List.generate(6000, (index) => index);
                    List<int>? aaa;
                    List<int> bbb = [10,20,54,2,7,5,9];
                    // BuBBleSort.bubbleSort(aaa);
                    // BuBBleSort.bubbleSort(bbb);
                    BuBBleSort.bubbleSort(ccc);
                    BuBBleSort.bubbleSort(ccc.reversed.toList());
                  },
                  text: "冒泡排序",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    DateTime start = DateTime.now();
                    List<int> ccc = List.generate(6000, (index) => index).reversed.toList();
                    List<int>? aaa;
                    List<int> bbb = [9,8,7,6,5,4,3,2,1];
                    // BuBBleSort.bubbleSort(aaa);
                    // BuBBleSort.bubbleSort(bbb);
                    QuickSort.quickSort(ccc,0,ccc.length - 1,start);
                  },
                  text: "快速排序",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                    // List<int> ccc = MergeSort.generateIntegers();
                    List<int> ccc = [5,9,1,4];
                    print('排序前的数组: $ccc');
                    MergeSort.sort(ccc,0,ccc.length - 1);
                  },
                  text: "合并排序",
                  sideColor: AppColors.black_3333),
              ordinaryButton(
                  onPressed: () {
                   getClassName();
                  },
                  text: "打印widget",
                  sideColor: AppColors.black_3333),
              Text('123456').intoContainer(color: Colors.red)
            ],
          ),
        ],
      ),
    );
  }


  @override
  void onCreate() {
    setTopBarVisible(true);
    setTopBarStyle(false);
    // setTopBarColor(Colors.red);
    setAppBarVisible(false);
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  double getVerticalMargin() => 0;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
