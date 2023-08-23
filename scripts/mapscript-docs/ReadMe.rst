MapScript Documentation Scripts
===============================

This folder contains scripts to regenerate various MapScript documentation pages
using the Python MapScript module. When there are new classes, global functions, or
constant values these scripts should be re-run.

To run first set-up a virtual environment (code here is for Windows using PowerShell, but Linux commands
should be similar):

.. code-block:: ps1

    C:\Python310\Scripts\virtualenv C:\VirtualEnvs\mapscript-docs-update
    C:\VirtualEnvs\mapscript-docs-update\Scripts\activate.ps1

    pip install mapscript==8.0.1
    $env:Path = "C:\MapServer\bin;" + $env:Path
    $env:MAPSERVER_DLL_PATH="C:\MapServer\bin"
    cd D:\GitHub\mapserver_docs\scripts\mapscript-docs

Updating the MapScript Constants
--------------------------------

.. code-block:: ps1

    python constants.py

Updating the MapScript Relationship Diagrams
--------------------------------------------

Requires https://graphviz.gitlab.io/_pages/Download/Download_windows.html
For DOT language see http://www.graphviz.org/doc/info/attrs.html
See also https://stackoverflow.com/questions/1494492/graphviz-how-to-go-from-dot-to-a-graph
For Entity Relationship diagram example see https://graphviz.readthedocs.io/en/stable/examples.html#er-py

.. code-block:: ps1

    pip install pydot
    $env:Path = "C:\Program Files (x86)\Graphviz2.38\bin;" + $env:Path
    python diagrams.py

Updating MapScript Objects
--------------------------

This script updates the include files listing the functions and classes available in MapScript.

.. code-block:: ps1

    python objects.py

Run all scripts:

.. code-block:: ps1

    python constants.py
    python diagrams.py
    python objects.py
