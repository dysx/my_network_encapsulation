import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/common/headerDelegate/sliverAppBar_delegate.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class NestedScrollViewTest extends StatefulWidget {
  NestedScrollViewTest({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new NestedScrollViewTestState();
}

class NestedScrollViewTestState extends State<NestedScrollViewTest>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  final GlobalKey<MyNestedScrollViewState> _key =
      GlobalKey<MyNestedScrollViewState>();
  TabController _tabController;
  bool isShowBlackTitle = false;
  String imageUrl =
      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2F1812.img.pp.sohu.com.cn%2Fimages%2Fblog%2F2009%2F11%2F18%2F18%2F8%2F125b6560a6ag214.jpg&refer=http%3A%2F%2F1812.img.pp.sohu.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1623482255&t=47faef9f0351c0633e5fe3545f7f3343';

  double _topBarHeight;
  Color _topColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    _topBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              //滚动并且是列表滚动的时候
              _onScroll(scrollNotification.metrics.pixels);
            }
            return true;
          },
          child: _build()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  //判断滚动改变透明度
  void _onScroll(offset) {
    if (offset > 50) {
      setState(() {
        isShowBlackTitle = true;
        _topColor = Colors.white;
      });
    } else {
      setState(() {
        isShowBlackTitle = false;
        _topColor = Colors.transparent;
      });
    }
  }

  Widget _buildBanner() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              height: _topBarHeight + 34,
              // color: _topColor,
              child: Column(
                children: [
                  SizedBox(height: _topBarHeight),
                  Container(
                    width: double.maxFinite,
                    height: 34,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Color(0x9CFFFFFF),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0D000000),
                            offset: Offset(0, 2.0),
                            blurRadius: 5,
                          )
                        ]),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "搜索",
                              ),
                            ],
                          ),
                        ),
                        // Positioned(
                        //   right: 15,
                        //   child: GestureDetector(
                        //     child: getImage("icon-26", imageWidth: 13),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _barList(String keyName) {
    return NestedScrollViewInnerScrollPositionKeyWidget(
        Key("HomeTab0"),
        ListView.separated(
          padding: EdgeInsets.only(top: 0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Text("0000${index}0000");
          },
        ));
  }

  Widget _build() {
    return MyNestedScrollView(
      controller: _scrollController,
      key: _key,
      headerSliverBuilder: (BuildContext context, bool f) {
        return <Widget>[
          SliverAppBar(
            // leading: new Container(
            //   margin: EdgeInsets.only(top: 20, bottom: 10),
            //   child: isShowBlackTitle
            //       ? Container(
            //     height: 50,
            //     color: Colors.red,
            //   )
            //       : Container(
            //     height: 50,
            //     color: Colors.yellow,
            //   ),
            // ),
            title: Container(
              width: double.maxFinite,
              height: 34,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Color(0xFFB2B2B2),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 2.0),
                      blurRadius: 5,
                    )
                  ]),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "搜索",
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: 15,
                  //   child: GestureDetector(
                  //     child: getImage("icon-26", imageWidth: 13),
                  //   ),
                  // ),
                ],
              ),
            ),
            actions: [
              Icon(Icons.more_horiz),
              SizedBox(width: 15)
            ],
            centerTitle: true,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
            expandedHeight: 290.0,
            backgroundColor: Colors.white,
            elevation: 0,
            //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
            forceElevated: f,
            // actions: <Widget>[
            //   new Container(
            //     margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
            //     child: isShowBlackTitle
            //         ? Container(
            //       height: 50,
            //       color: Colors.red,
            //     )
            //         : Container(
            //       height: 50,
            //       color: Colors.yellow,
            //     ),
            //   ),
            //   new Container(
            //     margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
            //     child: isShowBlackTitle
            //         ? Container(
            //       height: 50,
            //       color: Colors.red,
            //     )
            //         : Container(
            //       height: 50,
            //       color: Colors.yellow,
            //     ),
            //   ),
            // ],

            flexibleSpace: FlexibleSpaceBar(
              title: Text('123'),
              collapseMode: CollapseMode.pin,
              background:
              // Image.network(imageUrl,fit: BoxFit.cover)

              new Column(
                children: <Widget>[
                  new Container(
                    // alignment: Alignment.bottomCenter,
                    height: 290,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /* bottom: TabBar(
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),*/
          ),
          SliverPersistentHeader(
            pinned: true,
            // floating: true,
            delegate: SliverAppBarDelegate(
              maxHeight: 50,
              minHeight: 50,
              child: Container(
                color: Colors.red,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'tab1'),
                    Tab(text: 'tab2'),
                    Tab(text: 'tab3'),
                  ],
                )
              ),
            ),
          )
          // _buildBanner()
        ];
      },
      pinnedHeaderSliverHeightBuilder: () {
        return 0;
      },
      innerScrollPositionKeyBuilder: () {
        String index = "HomeTab";
        index += _tabController.index.toString();
        return Key(index);
      },
      body: Column(
        children: [
          // Padding(
          //     padding: EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
          //     child: Text('bar')),
          Expanded(
              child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              _barList("HomeTab0"),
              _barList("HomeTab1"),
              _barList("HomeTab2"),
            ],
          )),
        ],
      ),
    );
  }

  Widget _build1() {
    return MyNestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool f) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: MyNestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              // leading: new Container(
              //   margin: EdgeInsets.only(top: 20, bottom: 10),
              //   child: isShowBlackTitle
              //       ? Container(
              //     height: 50,
              //     color: Colors.red,
              //   )
              //       : Container(
              //     height: 50,
              //     color: Colors.yellow,
              //   ),
              // ),
              title: isShowBlackTitle ? Text('显示bar') : Text(''),
              centerTitle: true,
              pinned: true,
              floating: false,
              snap: false,
              primary: true,
              expandedHeight: 210.0,
              backgroundColor: Color(0xffF8F8F8),
              elevation: 0,
              //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
              forceElevated: f,
              actions: <Widget>[
                new Container(
                  margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
                  child: isShowBlackTitle
                      ? Container(
                          height: 50,
                          color: Colors.red,
                        )
                      : Container(
                          height: 50,
                          color: Colors.yellow,
                        ),
                ),
                new Container(
                  margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
                  child: isShowBlackTitle
                      ? Container(
                          height: 50,
                          color: Colors.red,
                        )
                      : Container(
                          height: 50,
                          color: Colors.yellow,
                        ),
                ),
              ],

              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: new Column(
                  children: <Widget>[
                    new Container(
                      height: 210,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: new Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: new CircleAvatar(
                                      backgroundImage:
                                          new NetworkImage(imageUrl),
                                      radius: 33.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  '名字',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "关注  123",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  height: 10,
                                  width: 1,
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                ),
                                Container(
                                  child: Text(
                                    "粉丝 200",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "简介: " + "这是简介",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /* bottom: TabBar(
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),*/
            ),
          ),
          // SliverPersistentHeader(
          //   delegate: SliverAppBarDelegate(
          //       minHeight: 60,
          //       maxHeight: 60,
          //       child: Container(
          //         height: 80,
          //         color: Colors.black,
          //       )),
          //   pinned: true,
          // ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        // These are the contents of the tab views, below the tabs.
        children: [
          ListView.separated(
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Text("0000${index}0000");
            },
          ),
          ListView.separated(
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Text("1111${index}1111");
            },
          ),
          ListView.separated(
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Text("2222${index}2222");
            },
          ),
        ],
      ),
    );
  }
}
