; ModuleID = 'bell'
source_filename = "bell"

%Qubit = type opaque
%Result = type opaque

define void @main() #0 {
entry:
  call void @__quantum__qis__h__body(ptr null)
  call void @__quantum__qis__cnot__body(ptr null, ptr inttoptr (i64 1 to ptr))
  call void @__quantum__qis__mz__body(ptr null, ptr null)
  call void @__quantum__qis__mz__body(ptr inttoptr (i64 1 to ptr),
                                      ptr inttoptr (i64 1 to ptr))
  call void @__quantum__rt__result_record_output(ptr inttoptr (i64 0 to ptr), ptr null)
  call void @__quantum__rt__result_record_output(ptr inttoptr (i64 1 to ptr), ptr null)
  ret void
}

declare void @__quantum__qis__h__body(ptr)

declare void @__quantum__qis__cnot__body(ptr, ptr)

declare void @__quantum__qis__mz__body(ptr, ptr)

declare void @__quantum__rt__result_record_output(ptr, ptr)

attributes #0 = { "EntryPoint" "requiredQubits"="2" "requiredResults"="2" }