import '../../network/dio_provider.dart';

final baseUrl = DioProvider.baseUrl;

class ApiUrlConstants {
  static String register = '$baseUrl/api/user/save';

  static String login = '$baseUrl/api/user/login';

  static String createQuizFromExcel = '$baseUrl/api/quizzes/create-from-excel';

  static String createQuiz = '$baseUrl/api/quizzes/add';

  static String editQuiz(int id) => '$baseUrl/api/quizzes/$id';

  static String getAllQuizByUser = '$baseUrl/api/quizzes/users';

  static String deleteQuiz(int id) => '$baseUrl/api/quizzes/$id';

  static String createTest = '$baseUrl/api/tests';

  static String createTestFromExcel = '$baseUrl/api/tests/create-from-excel';

  static String getTestFromQuizCode(String quizCode) =>
      '$baseUrl/api/tests/code/$quizCode';
}
