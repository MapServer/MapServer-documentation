MapScript API
=============

..
    .. py:currentmodule:: mapscript


.. autodata:: mapscript.MS_SUCCESS
   :annotation: 1

..
    Missing items

    DBF field types:

    FTDouble
    FTInteger
    FTInvalid
    FTString

    MESSAGELENGTH

    fromstring
    inspect
    intarray
    intarray_frompointer
    key
    shapeObj_fromWKT
    wkp_gmerc
    wkp_lonlat
    wkp_none
    MapServerChildError
    MapServerError
    ROUTINELENGTH
    SHX_BUFFER_PAGE

    mapscript.msGetErrorObj - doesn't exist? Perl only?

.. rubric:: Classes

.. autosummary::
    :toctree: stub 
    :template: class.rst
    
    mapscript.CompositingFilter
    mapscript.DBFInfo
    mapscript.LayerCompositer
    mapscript.MapServerChildError
    mapscript.MapServerError
    mapscript.OWSRequest
    mapscript.classObj
    mapscript.clusterObj
    mapscript.colorObj
    mapscript.errorObj
    mapscript.fontSetObj
    mapscript.hashTableObj
    mapscript.imageObj
    mapscript.intarray
    mapscript.labelCacheMemberObj
    mapscript.labelCacheObj
    mapscript.labelCacheSlotObj
    mapscript.labelLeaderObj
    mapscript.labelObj
    mapscript.layerObj
    mapscript.legendObj
    mapscript.lineObj
    mapscript.mapObj
    mapscript.markerCacheMemberObj
    mapscript.outputFormatObj
    mapscript.pointObj
    mapscript.projectionObj
    mapscript.queryMapObj
    mapscript.rectObj
    mapscript.referenceMapObj
    mapscript.resultCacheObj
    mapscript.resultObj
    mapscript.scaleTokenEntryObj
    mapscript.scaleTokenObj
    mapscript.scalebarObj
    mapscript.shapeObj
    mapscript.shapefileObj
    mapscript.styleObj
    mapscript.symbolObj
    mapscript.symbolSetObj
    mapscript.webObj

.. rubric:: MapScript Functions
   
.. autosummary::

    mapscript.msCleanup
    mapscript.msConnPoolCloseUnreferenced
    mapscript.msFreeImage
    mapscript.msGetErrorObj
    mapscript.msGetErrorString
    mapscript.msGetVersion
    mapscript.msGetVersionInt
    mapscript.msIO_getAndStripStdoutBufferMimeHeaders
    mapscript.msIO_getStdoutBufferBytes
    mapscript.msIO_getStdoutBufferString
    mapscript.msIO_installStdinFromBuffer
    mapscript.msIO_installStdoutToBuffer
    mapscript.msIO_resetHandlers
    mapscript.msIO_stripStdoutBufferContentHeaders
    mapscript.msIO_stripStdoutBufferContentType
    mapscript.msLoadMapFromString
    mapscript.msResetErrorList
    mapscript.msSaveImage
    mapscript.msSetup


..
    https://github.com/sphinx-doc/sphinx/pull/6423/files - reverted
    https://github.com/sphinx-doc/sphinx/issues/1980

..
    .. automodule:: mapscript
       :members:
       :undoc-members:
       :ignore-module-all: