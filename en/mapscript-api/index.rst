MapScript API
=============

Test2

.. currentmodule:: mapscript

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
    
    CompositingFilter
    DBFInfo
    LayerCompositer
    MapServerChildError
    MapServerError
    OWSRequest
    classObj
    clusterObj
    colorObj
    errorObj
    fontSetObj
    hashTableObj
    imageObj
    intarray
    labelCacheMemberObj
    labelCacheObj
    labelCacheSlotObj
    labelLeaderObj
    labelObj
    layerObj
    legendObj
    lineObj
    mapObj
    markerCacheMemberObj
    outputFormatObj
    pointObj
    projectionObj
    queryMapObj
    rectObj
    referenceMapObj
    resultCacheObj
    resultObj
    scaleTokenEntryObj
    scaleTokenObj
    scalebarObj
    shapeObj
    shapefileObj
    styleObj
    symbolObj
    symbolSetObj
    webObj

.. rubric:: MapScript Functions

.. autosummary::

    ~msCleanup
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