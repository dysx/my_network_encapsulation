import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

///@name: 逻辑页面
class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial());

  @override
  Stream<TestState> mapEventToState(
    TestEvent event
  ) async* {
    // TODO: implement mapEventToState
  }
}
