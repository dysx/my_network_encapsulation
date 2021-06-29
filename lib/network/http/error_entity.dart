import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';

class ErrorEntity with JsonConvert<ErrorEntity> {
	int code;
	String message;
	dynamic details;
	dynamic validationErrors;
}
