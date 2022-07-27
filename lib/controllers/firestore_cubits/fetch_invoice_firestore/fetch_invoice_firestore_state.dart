part of 'fetch_invoice_firestore_cubit.dart';

@immutable
abstract class FetchInvoiceFirestoreState {}

class FetchInvoiceFirestoreInitial extends FetchInvoiceFirestoreState {}
class FetchInvoiceFirestoreLoading extends FetchInvoiceFirestoreState {}
class FetchInvoiceFirestoreLoaded extends FetchInvoiceFirestoreState {
  List<Order> allorders;
  FetchInvoiceFirestoreLoaded({required this.allorders});
}
class FetchInvoiceFirestoreError extends FetchInvoiceFirestoreState {
  String err;
  FetchInvoiceFirestoreError({required this.err});
}
