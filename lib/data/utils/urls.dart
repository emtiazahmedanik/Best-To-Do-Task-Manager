class Urls{
  static const String baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registerUrl = "$baseUrl/Registration";
  static const String loginUrl = "$baseUrl/Login";
  static const String recoverEmail = "$baseUrl/RecoverVerifyEmail";
  static const String recoverOTP = "$baseUrl/RecoverVerifyOtp";
  static const String recoverResetPassword = "$baseUrl/RecoverResetPassword";
  static const String updateProfile = "$baseUrl/ProfileUpdate";
  static const String createTask = "$baseUrl/createTask";
  static const String taskStatusCount = "$baseUrl/taskStatusCount";
  static const String newTask = "$baseUrl/listTaskByStatus/New";
  static const String progressTask = "$baseUrl/listTaskByStatus/Progress";
  static const String completedTask = "$baseUrl/listTaskByStatus/Completed";
  static const String cancelledTask = "$baseUrl/listTaskByStatus/Cancelled";

}