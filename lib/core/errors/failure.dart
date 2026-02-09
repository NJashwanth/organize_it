/// Base failure type for domain and data layer errors.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Failure type for server-side errors.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
