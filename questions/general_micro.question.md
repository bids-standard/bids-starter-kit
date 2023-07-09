---
title: "General: How to specify the micro sign in MATLAB?"
---

BIDS requires physical units to be specified according to the SI unit symbol and
possibly prefix symbol (for example: mV, μV for milliVolt and microVolt).

The symbol used to indicate `µ` has unicode U+00B5, which is in MATLAB:

```matlab
char(181)
```

or

```matlab
native2unicode(181, 'latin1')
```
