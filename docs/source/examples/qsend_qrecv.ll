define void @main(i32 noundef %0, ptr noundef %1) #0 {
    entry:
        ; Varaible allocation
        %2 = alloca i32, align 4
        
        %3 = call i32 @__netqir__init(i32 noundef %0, ptr noundef %1)
        %4 = call i32 @__netqir__comm_rank(%Comm* @netqir_comm_world, ptr %2)

        %5 = load i32, ptr %2, align 4
        %6 = icmp eq i32 %5, 0
        br i1 %6, label %7, label %9

    7:
        %8 = call i32 @__netqir__qsend(%Qubit* null, i32 noundef 1, 
                                       %Comm* @netqir_comm_world)
    9:
        %10 = call i32 @__netqir__qrecv(%Qubit** null, i32 noundef 0, 
                                        %Comm* @netqir_comm_world)
        
        %11 = call i32 @__netqir__finalize()
}
declare i32 @__netqir__init()
declare void @__quantum__qis__h__body(%Qubit*)
declare i32 @__netqir__qsend(%Qubit*, i32, %Comm)
declare i32 @__netqir__qrecv(%Qubit**, i32, %Comm)
declare void @__netqir__finalize()