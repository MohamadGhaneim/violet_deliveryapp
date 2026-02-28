import 'package:deliveryapp/repository/sheard_preferances.dart';
import 'package:deliveryapp/util/model/delivery.dart';
import 'package:deliveryapp/util/services/user_service.dart';

class ProfileInteractor {
  final UserService userService;
  ProfileInteractor(this.userService);

  Future<Delivery> getDelivery() async {
    try {
      final delivery = await userService.getDelivery();

      await PrefHelper.saveDelivery(delivery);
      return delivery;
    } catch (e) {
      throw Exception("ProfileInteractor getDelivery : $e ");
    }
  }

  Future<void> updateDelivery(Delivery delivery) async {
    try {
      await userService.updateDelivery(delivery);
      await PrefHelper.updateDelivery(delivery);
    } catch (e) {
      throw Exception("ProfileInteractor updateDelivery : $e ");
    }
  }
}
