class PointTest {

  final int x;
  final int y;
  const PointTest(this.x,this.y);

}

class PageTest{
  static int currentPage = 1;

  static void scorllDown(){
    currentPage--;
    print("ScrollDown...$currentPage");
  }

  void scorllUp(){
    currentPage++;
    print("ScrollUp...$currentPage");
  }

}

class DartTest {

  PageTest pageTest = PageTest();
  void test() {
    pageTest.toString();
    PageTest.scorllDown();
  }

}