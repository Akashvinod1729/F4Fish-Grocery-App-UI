import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class DeleteCartUseCase extends UseCase<NoParams, int> {
  final ProductRepository repository;

  DeleteCartUseCase(this.repository);

  @override
  Future<NoParams> call(int params) {
    final d = repository.deleteCartProduct(params);
    return Future.value(NoParams());
  }
}
