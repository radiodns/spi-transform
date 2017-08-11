# spi-transform

Transformations from RadioEPG 1.0/1.1 to the new ETSI TS 102 818 Hybrid Radio
SPI (and back again).

Implemented as a set of XSLT documents to apply to existing RadioEPG and SPI
documents in order to be able to translate between the two.

The following behaviour is intentional:

* Transforms apply themselves in a non-destructive manner

  The transform should only attempt to modify elements that correctly adhere to
  the relevant original specification and should leave all other elements that
  may exist unaffected.

* The transforms do not enforce validity

  An invalid input document may produce an invalid output document with no
  resulting errors reported.

## Status

Currently, transforms exist for:

*Service Information*

* XSI (RadioEPG 1.0/1.1) to SI (SPI) 
* SI (SPI) to XSI (RadioEPG 1.1)
