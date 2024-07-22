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

.. literalinclude:: ../examples/qsend_qrecv.ll
   :language: llvm

In this case, #TODO: Add figure (y quizas una puerta para que el circuito no sea solo enviar y recibir).

Collective communication
========================
