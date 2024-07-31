Datatypes
=========

The used datatypes in QIR (and LLVM) will be used, except for the new datatypes
that will be added in this section. Among the most important datatypes defined
in QIR are ``%Qubit`` and ``%Array``.

The intention when adding communicators would be to implement all the features 
of MPI for the use of process groups, topologies or graphs.

**Datatypes defined in NetQIR**

.. code-block:: llvm 

    %Comm = type opaque

Stores the information of the process set (a group) and the communication topology.

.. code-block:: llvm 

    %Group = type opaque

Set of processes of a communicator.