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
The following code shows how to use the ``qsend`` directive to send a qubit from one node to another.

.. literalinclude:: ../examples/qsend_qrecv/qsend_qrecv.ll
   :language: llvm
   :caption: Example of ``qsend`` and ``qrecv`` directives.

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

The latter will most like be employed in network communications while the first one, meaning the single file, will probably
be employed when working with a multicore infrastructure, as happens with MPI. **ESTO ES CIERTO?** 

Collective communication
========================
