Examples
########

In order to understand how this communication directives introduced by NetQIR work, we
present several simple examples.

Every piece of code from now on will begin with the following code block.

.. code-block:: llvm

    %Qubit = type opaque
    %Comm = type opaque
    @netqir_comm_world = external global %Comm, align 1

So, in order to simplify the examples it is going to be ommited. These instructuctions define
the ``%Qubit`` and the ``%Comm`` datatype along with the deafult communicator ``@netqir_comm_world``.
There are other directives that are also going to be common, but the previous ones are used in every
example.

Point-to-point communication
============================

In this section we will try to show how point-to-point communication works in NetQIR.

Employement of ``qsend`` and ``qrecv`` directives
-------------------------------------------------

Single file for ``qsend`` and ``qrecv``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following code shows how to use the ``qsend`` directive to send a qubit from one node to another.

.. literalinclude:: ../examples/qsend_qrecv/qsend_qrecv.ll
   :language: llvm
   :caption: Example of ``qsend`` and ``qrecv`` directives.


One file for each directive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This previous program follows a very *MPI-like* structure, with a single file defining all the processes and an conditional
structure to decide if the process is going to send or receive the qubit. It is also possible to have two files, one
responsible for sending the qubit and the other for receiving it. Both structures will be perfectly valid, the only
important thing is to give both processes the same communicator. But this is going to be the resposability of the backend.

.. literalinclude:: ../examples/qsend_qrecv/qsend.ll
   :language: llvm
   :caption: Example of ``qsend`` directive in a single file.

.. literalinclude:: ../examples/qsend_qrecv/qrecv.ll
   :language: llvm
   :caption: Example of ``qrecv`` directive in a single file.

Two examples have been shown for the ``qsend`` and ``qrecv`` directives: a **single file for both process types** and **one
file for each process type**. The first example is commonly used by multicore infrastructure, e.g. MPI. On the other hand, 
the second example is intended for network communications where there is no perfectly coordinated computation.

Sending and receiving and array of qubits
-----------------------------------------

In this case, the structure employed---instead of ``%Qubit``---is ``%Array``. This is because we are going to
send and receive a slot of qubits. This structure is the same one that QIR introduces, so the reader is referred to the 
`QIR specification <https://github.com/qir-alliance/qir-spec>`_ for more information.

.. literalinclude:: ../examples/qsend_qrecv/qsend_qrecv_array.ll
   :language: llvm
   :caption: Example of ``qsend`` and ``qrecv`` directives with an array of qubits.

Similar to before, this could be splitted into two different files, one for sending and the other for receiving. In this case,
this examplification will be ommited due to the similarity with the previous example.

Teledata vs telegate
--------------------

Both ``qsend`` and ``qrecv`` directives have two versions: ``qsend`` and ``qsend_array`` and ``qrecv`` and ``qrecv_array``, this
was already mentioned in the previous examples. But, beneath this two versions, two more directives are available for each: 
on the first case ``qsend_teledata`` and ``qsend_telegate``, and on the second case ``qrecv_array_teledata`` and ``qrecv_array_telegate``.
This directives are used to explicitly determine whether the communication is done with the teledata protocol or with the telegate protocol.

This way of marking the communication protocol is not random. A flag inside the communication directives could be used to determine the
protocol. But this flag could represent a barrier for compiler optimizations, because in order to determine which is the protocol
it should know the value of the aforementioned flag. This could be a problem when the flag is not a constant.

The use of these directives is exactly the same as the previous ones, the only difference is that the programmer has the control over the
protocol used for the communication. But the actual code is exactly the same except for the directive name.

Collective communication
========================

After seing the most basic communication directives, i.e. sending and receiving information between two different parties, we are going to 
see how collective communication works in NetQIR. This type of communication represents a one to many, or vice versa, way of communicating, 
where one party sends information to all the others or all the parties send information to one.

This is pretty common in classical computing with, for example, MPI directives such as ``MPI_Gather``, ``MPI_Scatter``, ``MPI_Bcast``, etc. 
This are operations that, nevertheless, are not directly translatable to quantum computing. There are several reasons for that, but the most
important one is the non-cloning theorem. The fact that a quantum state cannot be copied eliminates the possibility of getting a broadcast
operation understood as the classical one: one party sends a copy of the information to all the others.

This is why the :ref:`Collective communication <collective_communication>` section has introduced several functions that adapt the collective
communication paradigm to quantum computing. These functions are the targets of the following examples.