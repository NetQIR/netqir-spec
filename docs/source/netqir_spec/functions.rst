Functions
=========

State functions
---------------
.. cpp:function:: i32 __netqir__init(i32 argc, i8** argv)

    Initializes the distributed environment.

    :param i32 argc: Number of arguments.
    :param i8** argv: Arguments.

    :return: 0 if successful, 1 otherwise.

.. cpp:function:: i32 __netqir__finalize(void)

    Finalize the distributed environment.

    :return: 0 if successful, 1 otherwise.

Operate datatypes functions
--------------------------


Communication functions
-----------------------
The communication functions include the quantum send and receive functions, each one for %Qubit and %Array. In addition, this functions has different versions in function use one or another technique for the distribution. Finally, also include directives to perform and send the result of qubit measurements.

.. cpp:function:: i32 __netqir__qsend_array(Array* array, i32 count, i32 dest, Comm comm)

    Generic blocking send for an array of qubits. The compiler decides which sending technique is used.
    
    :param %Array* array: Array of qubits.
    :param i32 count: Number of qubits.
    :param i32 dest: Destination rank.
    :param %Comm comm: Communicator.

    :return: 0 if successful, 1 otherwise.