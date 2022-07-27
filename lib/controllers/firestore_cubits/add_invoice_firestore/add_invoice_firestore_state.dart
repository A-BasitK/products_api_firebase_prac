part of 'add_invoice_firestore_cubit.dart';

@immutable
abstract class AddInvoiceFirestoreState {}

class AddInvoiceFirestoreInitial extends AddInvoiceFirestoreState {}
class AddInvoiceLoading extends AddInvoiceFirestoreState {}
class AddInvoiceLoaded extends AddInvoiceFirestoreState {}
class AddInvoiceError extends AddInvoiceFirestoreState {
  var err;
  AddInvoiceError({required this.err});
}//kkk
