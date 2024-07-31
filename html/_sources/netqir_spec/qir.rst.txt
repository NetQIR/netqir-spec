QIR clarifications
==================

In this section different aspects of QIR will be discussed. During NetQIR development, some aspects of QIR were found problematic
and affected the development of NetQIR. This section aims to clarify these aspects or, at least, notice them.

Opaque vs typed pointers
------------------------

An important aspect in later versions of LLVM (specifically, LLVM 14 and so on) is the inclusion of `opaque pointers <https://llvm.org/docs/OpaquePointers.html>`_. This way of
programming, as it is much better explained in the previous link, removes a lot of complexity of the IR---eliminating no-op bitcast operations
that hinder the development---among other advantages.

QIR does not consider this type of pointers and, as it is shown in this documentation, it uses typed pointers for the quantum datatypes--- ``%Qubit*``, ``%Result*`` and so on and 
so forth---. This could adapted to this new LLVM opaque pointers feature, but it would require a change in the QIR specification. We leave here a comparison between a program
using the typed pointers and the same program using the opaque pointers in order to show how it would change:

.. literalinclude:: ../llvm-code/typed_opaque/typed_pointers.ll
   :language: llvm
   :caption: Program with the usual QIR typed pointers.

.. literalinclude:: ../llvm-code/typed_opaque/opaque_pointers.ll
   :language: llvm
   :caption: Same program with opaque pointers.
   
As one may notice, the second program---where opaque pointers are employed---is much less readable. This is because, in this example, one cannot rapidly identify the type of the pointers and, therefore,
understand the program. But these are the kind of trade-offs that have to be made in order to have a standard contained in LLVM. It forces you to develop the standard in the same direction
as the LLVM. In this case, this is not even a disadvantage as the code is from an intermediate representation, which is not meant to be readable. But, because of the lack of a abstractions in 
quantum computing, a code without any qubit or result type in it does not look familiar to look at.


Arrays
------

A natural extension of the qubit datatype is the array of qubits. It is natural because it is common that, for example, it is desirable to apply a gate to a set of qubits. 
This happens often in quantum algorithms with, for example, the Hadamard gate or with the rotation gates. In QIR, the array of qubits is defined as an opaque type and it requires
a dynamic memory reservation using the ``__quantum__rt__qubit_allocate_array`` function. This function returns a pointer to the array of qubits.

The problem with this approach is that quantum circuits have, to the best of our knowledge, a fixed number of qubits. This means that the number of qubits is known at compile time, 
making the dynamic memory reservation unnecessary and, more importantly, unnefficient. Not only because the memory allocation has to be done in execution time, slowing the execution 
of the quantum program, but also because it disables the possibility of performing optimizations in the quantum circuit. This is because the number of qubits in the array would not be known in
compile time.

A possible approach would be to treat the array of qubits as a fixed-size array. And LLVM allows to combine this fixed arrays with opaque pointers, using the following syntax: ``<4 x ptr>``. Where
``4`` is the number of elements in the array. In this case, to recover the qubit at position ``3`` in the array, the following code would be used:

.. code-block:: llvm

    %qubit_array = <4 x ptr> <ptr inttoptr (i64 0 to ptr), ptr inttoptr (i64 1 to ptr), 
                              ptr inttoptr (i64 2 to ptr), ptr inttoptr (i64 3 to ptr)>
    %qubit = getelementptr %Qubit, <4 x ptr> %qubit_array, i32 3

It can be observed how the qubit initialization employed by QIR is maintained (meaning the pieces of code ``ptr inttoptr (i64 i to ptr)``).