---
jupyter:
    jupytext:
        text_representation:
        format_name: myst
    kernelspec:
        display_name: Python 3
        language: python
        name: python3
    repository:
        url: https://github.com/bids-standard/BIDS-Starter-Kit
---

# Welcome to the BIDS Starter Kit

<!-- <head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head> -->

<div align="center" style="padding:10px">
  <strong>How to get started with the Brain Imaging Data Structure</strong>
</div>

<div align="center" style="padding:10px">
  A community-curated collection of tutorials, wikis, and templates to get you started with creating BIDS compliant datasets.
</div>

<div align="center">
  <h4>
    <a href="http://bids-specification.readthedocs.io/">
      Specification
    </a>
    <span> | </span>
    <a href="https://bids-standard.github.io/bids-starter-kit/FAQ.html">
      FAQ
    </a>
    <span> | </span>
    <a href="https://mattermost.brainhack.org/brainhack/channels/bids-starter-kit">
      Chat
    </a>
    <span> | </span>
    <a href=https://neurostars.org/tags/bids>
      Forum
    </a>
    <span> | </span>
    <a href=https://www.youtube.com/channel/UCxZUcYfd_nvIVWAbzRB1tlw>
      Youtube
    </a>
    <span> | </span>
    <a href=https://anchor.fm/bids-maintenance>
      Podcast
    </a>
  </h4>
</div>

<div class="iframe-container">
  <iframe
    src="https://www.youtube.com/embed/-c4PUhTwmz4"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
  </iframe>
</div>

## Motivation

The primary goal of this project is to simplify the process of learning about
the Brain Imaging Data Structure (BIDS). We hope that the resources in this
wiki, such as links to tutorials, easy-to-read documentation, and code will make
BIDS easier to adopt. In order to remain up to date with the continuously
changing BIDS specifications, we have adopted a similarly open model to allow
[contributions](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md)
from the community.

## Project Summary

Neuroimaging and neurophysiology data can be costly in both time and money to
acquire. This creates a barrier for many underfunded researchers without access
to the required equipment. Responsible data sharing can level the playing field,
but the many different specifications of these acquired images cause portability
issues between different labs and scientists. BIDS is a framework for organizing
data that standardizes file organization and dataset description between
different researchers.

### How do I find information?

For general information to help you get started with BIDS, we recommend browsing
this book. It includes pages such as an overall introduction to the BIDS folder
structure, links to tutorials, and a glossary to help you with some of the
technical terms.

For metadata file templates or code to help you get started, please scroll up to
find the appropriate files that are available in your language of choice.

Finally, for more advanced knowledge that may pertain to specific use cases for
your data, please refer to the full
[BIDS Specification](https://bids-specification.readthedocs.io/en/stable/)

## Philosophy

The most important part of BIDS are the users: if more people use it, more data
will be shared and the more powerful it will become. <strong>We want to make it
easy to learn</strong> and more adopted. Since BIDS is platform independent and
still an adapting, growing tool, the greater the community, the better it will
be.

Another part is that BIDS is striving to not reinventing other standards and metadata ontologies but reuse them:

![BIDS-minder](./images/BIDS-minder.svg)

## Benefits

### For the public good

-   Lowers scientific waste
-   Gives opportunity to less-funded researchers
-   Improves efficiency
-   Spurs innovation

### For yourself

-   You are likely the future user of the data and data analysis pipelines
    you’ve developed
-   Enables and simplifies collaboration
-   Reviewers and funding agencies like to see reproducible results
-   Open-science based funding opportunities and awards available (for instance:
    OHBM Replication Award, Mozilla Open Science Fellowship, Google Summer of
    Code, and so on.)

## Users

BIDS is for everyone! Programming is not required, it simply makes some
processes more efficient. All users can take part in the benefits such as
organized data, reproducible research, and data sharing.
![users](https://i.imgur.com/0iAMuJ8.png)

## Acknowledgements

### Sponsor Organizations

<a href="https://summerofcode.withgoogle.com/"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/GSoC.png/220px-GSoC.png" width="125" height="125" title="GSOC" alt="GSOC"></a>
<a href="https://www.incf.org/"><img src="https://www.eudat.eu/sites/default/files/styles/medium/public/logo/INCF_0.png?itok=uRT54XCM" width="200" height="125" title="INCF" alt="INCF"></a>
<a href="https://www.arnoldventures.org/newsroom/laura-and-john-arnold-foundation-announces-3-8-million-grant-to-stanford-university-to-improve-the-quality-of-neuroscience-research"><img src="https://www.arnoldventures.org/static/img/logo-on-light.svg" width="200" height="125" title="Arnold Ventures" alt="Arnold Ventures"></a>
<a href="http://grantome.com/grant/NIH/R24-MH114705-01"><img src="http://grantome.com/images/funders/NIH.png" width="125" height="125" title="NIH" alt="NIH"></a>

<br>

[gsoc]: https://summerofcode.withgoogle.com
[patrick-github]: https://github.com/Park-Patrick
[contributing]:
    https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md
