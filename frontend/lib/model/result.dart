class Result {
  final int duration; // in milliseconds
  final int latency; // in milliseconds
  final int reqPerSec;
  final int requests;
  final int errors;

  Result({
    required this.duration,
    required this.latency,
    required this.reqPerSec,
    required this.requests,
    required this.errors,
  });

  static Result zero() {
    return Result(
      duration: 0,
      latency: 0,
      reqPerSec: 0,
      requests: 0,
      errors: 0,
    );
  }

  @override
  String toString() {
    return """
Result {
  duration: $duration,
  latency: $latency,
  reqPerSec: $reqPerSec,
  requests: $requests,
  errors: $errors
}
""";
  }
}
