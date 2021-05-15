MapScript API
=============

.. currentmodule:: mapscript

MapScript Classes
-----------------

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

MapScript Functions
-------------------

.. autosummary::

    ~msCleanup
    msConnPoolCloseUnreferenced
    msFreeImage
    msGetErrorObj
    msGetErrorString
    msGetVersion
    msGetVersionInt
    msIO_getAndStripStdoutBufferMimeHeaders
    msIO_getStdoutBufferBytes
    msIO_getStdoutBufferString
    msIO_installStdinFromBuffer
    msIO_installStdoutToBuffer
    msIO_resetHandlers
    msIO_stripStdoutBufferContentHeaders
    msIO_stripStdoutBufferContentType
    msLoadMapFromString
    msResetErrorList
    msSaveImage
    msSetup


..
    https://github.com/sphinx-doc/sphinx/pull/6423/files - reverted
    https://github.com/sphinx-doc/sphinx/issues/1980

..
    .. automodule:: mapscript
       :members:
       :undoc-members:
       :ignore-module-all:

MapScript Constants
-------------------

.. include:: constants/index.rst
