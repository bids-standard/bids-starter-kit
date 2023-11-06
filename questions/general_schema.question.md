---
title: "General: Is there a machine readable version of the BIDS specification?"
---

Yes. The BIDS specification exist as a schema.
The BIDS schema is a machine readable representation of the BIDS Standard.
It is (by and large) the BIDS Specification, but written in a declarative form.

The BIDS schema is available in two machine readable formats:

- as a set of [YAML](https://en.wikipedia.org/wiki/YAML) files in the [BIDS specification repository](https://github.com/bids-standard/bids-specification/src/schema)
- as a [single json file](https://bids-specification.readthedocs.io/en/stable/schema.json)

A light-weight introduction to the schema can be found [here](https://bids-extensions.readthedocs.io/en/latest/schema/).

A full description of the schema can be found on this [website](https://bidsschematools.readthedocs.io/en/latest/?badge=latest)
where you will also find the documentation for the python package
to interact with the schema, [bidsschematools](https://pypi.org/project/bidsschematools/).
