.. index::
   pair: MapScript; API

.. _swig:

.. currentmodule:: mapscript

*****************************************************************************
 SWIG MapScript API Reference
*****************************************************************************

:Author: Sean Gillies
:Author: Steve Lime
:Contact: steve.lime at dnr.state.mn.us
:Author: Frank Warmerdam
:Contact: warmerdam at pobox.com
:Author: Umberto Nicoletti
:Contact: umberto.nicoletti at gmail.com
:Author: Tamas Szekeres
:Contact: szekerest at gmail.com
:Author: Daniel Morissette
:Contact: dmorisette at mapgears.com
:Author: Jeff McKenna
:Contact: jmckenna at gatewaygeomatics.com
:Author: Seth Girvin
:Contact: sethg at geographika.co.uk
:Last Updated: 2023-06-13

=============================================================================
 Introduction
=============================================================================

This documentation is for the MapScript interface to 
MapServer generated by SWIG. 

To make the document as agnostic as possible, we refer to
the following types: int, float, and string.  There are yet no MapScript
methods that return arrays or sequences or accept array or sequence arguments.

We will use the SWIG term *immutable* to indicate that an attribute's value
is read-only.

Note that because of the way that MapScript is generated many confusing,
meaningless, and even dangerous attributes might be exposed by objects.

.. warning::

   As of the MapServer 8.0.0 release PHP support is only available through
   MapServer's :ref:`SWIG API <swig>`.  The unmaintained `native` PHP MapScript
   support was removed.
   
 .. note::

    PHP support is included in the SWIG API as of the MapServer 7.4.0 release. 
    PHP 8.2 and PHP 8.1 are currently supported with MapServer 8.0.1.    

=============================================================================
 Appendices
=============================================================================

Language-specific extensions are described in the following appendices

:ref:`python`

=============================================================================
MapScript Classes
=============================================================================

.. include:: classes.rst

=============================================================================
MapScript Functions
=============================================================================

.. include:: functions.rst

=============================================================================
MapScript Constants
=============================================================================

.. include:: constants/index.rst
