part of 'delete_invoice_firestore_cubit.dart';

@immutable
abstract class DeleteInvoiceFirestoreState {}

class DeleteInvoiceFirestoreInitial extends DeleteInvoiceFirestoreState {}
class DeleteInvoiceFirestoreDeleting extends DeleteInvoiceFirestoreState {}
class DeleteInvoiceFirestoreDeleted extends DeleteInvoiceFirestoreState {}
class DeleteInvoiceFirestoreError extends DeleteInvoiceFirestoreState {}
