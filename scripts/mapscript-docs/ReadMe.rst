MapScript Documentation Scripts
===============================

This folder contains scripts to regenerate various MapScript documentation pages
using the Python MapScript module. When there are new classes, global functions, or
constant values these scripts should be re-run.

To run first set-up a virtual environment (code here is for Windows, but Linux commands
should be similar):

.. code-block:: bat

    C:\Python38\Scripts\virtualenv.exe C:\VirtualEnvs\mapscript-docs-update
    C:\VirtualEnvs\mapscript-docs-update\Scripts\activate
    python -m pip install pip -U

    pip install --index-url https://test.pypi.org/simple/ mapscript==7.7.1
    REM following maybe required if there is a clash of sqlite versions
    copy C:\MapServer\bin\sqlite3.dll C:\VirtualEnvs\mapscript-docs-update\Lib\site-packages\mapscript
    SET PATH=C:\MapServer\bin;%PATH%
    SET MAPSERVER_DLL_PATH=C:\MapServer\bin
    cd /D mapserver/scripts/mapscript-docs

Updating the MapScript Constants
--------------------------------

.. code-block:: bat

    python constants.py

Updating the MapScript Relationship Diagrams
--------------------------------------------

Requires https://graphviz.gitlab.io/_pages/Download/Download_windows.html
For DOT language see http://www.graphviz.org/doc/info/attrs.html
See also https://stackoverflow.com/questions/1494492/graphviz-how-to-go-from-dot-to-a-graph
For Entity Relationship diagram example see https://graphviz.readthedocs.io/en/stable/examples.html#er-py

.. code-block:: bat

    pip install pydot
    SET PATH=C:\Program Files (x86)\Graphviz2.38\bin;%PATH%
    python diagrams.py

Updating MapScript Objects
--------------------------

This script updates the include files listing the functions and classes available in MapScript.

.. code-block:: bat

    python objects.py

Run all scripts:

.. code-block:: bat

    python constants.py
    python diagrams.py
    python objects.py
