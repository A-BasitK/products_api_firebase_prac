part of 'update_invoice_firestore_cubit.dart';

@immutable
abstract class UpdateInvoiceFirestoreState {}

class UpdateInvoiceFirestoreInitial extends UpdateInvoiceFirestoreState {}
class UpdateInvoiceFirestoreUpdating extends UpdateInvoiceFirestoreState {}
class UpdateInvoiceFirestoreUpdated extends UpdateInvoiceFirestoreState {
  OrderModel orderDetails;
  UpdateInvoiceFirestoreUpdated({required this.orderDetails});
}
class UpdateInvoiceFirestoreError extends UpdateInvoiceFirestoreState {
  String err;
  UpdateInvoiceFirestoreError({required this.err});
}