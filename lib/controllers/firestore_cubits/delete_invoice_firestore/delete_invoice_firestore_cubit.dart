import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_invoice_firestore_state.dart';

class DeleteInvoiceFirestoreCubit extends Cubit<DeleteInvoiceFirestoreState> {
  DeleteInvoiceFirestoreCubit() : super(DeleteInvoiceFirestoreInitial());
}
