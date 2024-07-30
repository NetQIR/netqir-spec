%Array = type opaque

define void @main(i32 noundef %0, ptr noundef %1) #0 {
    entry:
        ; Variable allocation
        %2 = alloca i32, align 4
        %sent_qubits = call %Array* @__quantum__rt__qubit_allocate_array(i64 3)

        ; Init the NetQIR communication and get the rank of the process
        %3 = call i32 @__netqir__init(i32 noundef %0, ptr noundef %1)
        %4 = call i32 @__netqir__comm_rank(%Comm* @netqir_comm_world, ptr %2)

        ; Choose if it is the process receiving or sending the qubit
        %5 = load i32, ptr %2, align 4
        %6 = icmp eq i32 %5, 0
        br i1 %6, label %7, label %9

    ; Process sending
    7:
        %8 = call i32 @__netqir__qsend_array(%Array* %sent_qubits, i32 noundef 1,
                                             i32 noundef 3, %Comm* @netqir_comm_world)
        
    ; Process receiving
    9:
        %10 = call i32 @__netqir__qrecv_array(%Qubit** null, i32 noundef 0,
                                        i32 noundef 3, %Comm* @netqir_comm_world)
        
        ; End of the program
        %11 = call i32 @__netqir__finalize()
}

; Function declaration
declare i32 @__netqir__init()
declare i32 @__netqir__qsend_array(%Array*, i32, i32, %Comm)
declare i32 @__netqir__qrecv_array(%Array**, i32, i32, %Comm)
declare void @__netqir__finalize()