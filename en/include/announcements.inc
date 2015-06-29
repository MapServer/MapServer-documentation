**2015-06-26 - MapServer 7.0.0-beta2, MapServer 6.4.2 and TinyOWS 1.1.1 are released**

This is a security release to mitigate the effects of an issue in older versions of libxml2 (<=2.8).
You are strongly recommended to update your systems if using an unpatched version of libxml2 < 2.8 as
it may lead to the information disclosure of any file readable by the user running the mapserver
services.

MapServer 7.0 beta2 is being simultaneously released and contains a number of fixes to issues that
were discovered during the beta1 test phase. Please help us pushing out a final 7.0 by testing this
beta and reporting any issues you may have.

:ref:`changelog <changelog-7-0-0-beta2>`
:ref:`changelog <changelog-6-4-2>`

Head to :ref:`download` to obtain a copy.

**2015-02-12 - MapServer 7.0.0-beta1 is released**

The first beta for MapServer 7.0 has been released. The list of
major changes for this release can be found in the :ref:`7.0 announcement <announce-7-0>`.
See the :ref:`changelog <changelog-7-0>`
for the full list of changes and head to :ref:`download` to obtain a copy.

**2014-01-02 - MapServer 6.4.1, 6.2.2, 6.0.4 and 5.6.9 are released**

Releases for the stable branches of MapServer have been released in order
to fix a potential leakage of information through an SQL injection when 
using TIME filtering in conjunction with postgis backends. More information
can be found in the dedicated issue: `#4834 <https://github.com/mapserver/mapserver/issues/4834>`__.

Changelogs for each specific version can be found here:

 * :ref:`6.4.0 to 6.4.1 changes <changelog-6-4-1>`
 * :ref:`6.2.1 to 6.2.2 changes <changelog-6-2-2>`
 * :ref:`6.0.3 to 6.0.4 changes <changelog-6-0-4>`
 * 5.6.9 contains only the fix for #4834

Head to :ref:`download` to obtain copies.

**2014-01-03 - MapCache 1.2.1 is released**

MapCache 1.2.1 has been released. Head to :ref:`download` to obtain a copy.

**2013-09-17 - MapServer 6.4.0 is released**

MapServer 6.4.0 has been released. Major changes since 6.2 can be found in the
in :ref:`the 6.4 announcement <announce-6-4>`. For
the small list of changes since RC1, see :ref:`the final changelog <changelog-6-4-0>`,
then head to :ref:`download` to obtain a copy.

**2013-04-19 - MapServer 6.2.1 is released**

MapServer 6.2.1 has been released.  See :ref:`the changelog <changelog-6-2-1>`
for more details and head to :ref:`download` to obtain a copy.

**2012-11-14 - MapServer Suite 12.11 is released**

The first MapServer Suite, numbered 12.11, and containing MapServer 6.2.0, MapCache
1.0.0 and TinyOWS 1.1.0 has been released. See :ref:`the release announcement <announce-6-2>`
for more details and head to :ref:`download` to obtain a copy.

**2012-11-14 - MapServer 6.2.0 is released**

MapServer 6.2.0 has been released. See :ref:`the release announcement <announce-6-2>`
for more details, :ref:`the changelog since RC1 <changelog-6-2-0>` and head
to :ref:`download` to obtain a copy.

**2012-10-10 - MapServer 6.2.0 RC1 is released**

MapServer 6.2.0-RC1 has been released.  See :ref:`the changelog <changelog-6-2-0-rc1>`
for more details and head to :ref:`download` to obtain a copy.

**2012-05-18 - MapServer 6.0.3 is released**

MapServer 6.0.3 has been released.  See `the release announcement <http://lists.osgeo.org/pipermail/mapserver-users/2012-May/072329.html>`__
for more details and head to :ref:`download` to obtain a copy.

**2012-02-08 - TinyOWS 1.0.0 is released**

TinyOWS 1.0.0 has been released.  See `the release announcement <http://lists.osgeo.org/pipermail/mapserver-users/2012-February/071478.html>`__
for more details. (Note that TinyOWS will be part of the MapServer project starting with version 6.2)
