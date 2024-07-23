define void @main(i32 noundef %0, ptr noundef %1) #0 {
    entry:
        ; Variable allocation
        %2 = alloca i32, align 4
        
        ; Init the NetQIR communication and get the rank of the process
        %3 = call i32 @__netqir__init(i32 noundef %0, ptr noundef %1)
        %4 = call i32 @__netqir__comm_rank(%Comm* @netqir_comm_world, ptr %2)
    
        ; Process sending
        %5 = call i32 @__netqir__qsend(%Qubit* null, i32 noundef 1, 
                                       %Comm* @netqir_comm_world)
        
        ; End of the program
        %6 = call i32 @__netqir__finalize()
}

; Function declaration
declare i32 @__netqir__init()
declare i32 @__netqir__qsend(%Qubit*, i32, %Comm)
declare void @__netqir__finalize()