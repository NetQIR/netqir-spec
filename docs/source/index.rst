NetQIR specification
====================

**NetQIR** is an intermediate representation for distributed systems. It is born from QIR, the intermediate representation for
monolithic quantum computing. This specification aims to show the added functionalities employed **on top** of the ones already implemented by QIR.
This means that NetQIR does not aim to replace QIR, but to extend it, similar as MPI extends C. Our ultimate goal is to have a proper intermediate
representation for distributed quantum systems.

Joe's Recipes
=============

Below are a collection of my favourite recipes. I highly recommend the
:recipe:ref:`TomatoSoup` recipe in particular!

.. note::
   This project is under active development.

.. toctree::
   :maxdepth: 3
   :caption: NetQIR Specification

   netqir_spec/datatypes
   netqir_spec/functions