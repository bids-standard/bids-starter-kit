This is Patrick Park's Google Summer of Code final report for his work on the
[BIDS Starter Kit](https://github.com/bids-standard/bids-starter-kit).

If you have reached this page from a different source, and want an overview of
the project, please check out our README file at
<https://github.com/bids-standard/bids-starter-kit>.

The work completed by Patrick Park during the Google Summer of Code is archived
on zenodo as v1.0.2 under DOI 1344669 at
<https://doi.org/10.5281/zenodo.1344669>

## The Big Picture

An open source project is one where code and some data is shared publicly.
Rather than the traditional approach of hiding processes and making them
exclusive, open science principles prioritize transparency, diversity, and
reproducibility to foster collaboration.

<img align="right" width="35%" src="https://i.imgur.com/zxmd6W5.jpg" alt="sharing-pot"/>

Imagine you are a carrot farmer trying to make dinner. You could make carrot
soup by yourself, but you could also share ingredients with the neighbours to
make a much tastier soup with onions, greens, and some salt. Some people may be
able to contribute more than others -- but everyone benefits.

In neuroscience, data such as magnetic resonance images and physiology readings
can be costly in both time and money to acquire. This creates a barrier for many
underfunded researchers without access to the required equipment. Responsible
data sharing can level the playing field, but incompatible specifications cause
portability issues between different labs and scientists. The brain imaging data
standard (BIDS) is a framework for organizing data that standardizes datasets
across different researchers to enable easier sharing.

## My role

The primary goal of this project was to simplify the process of learning about
BIDS and engage more users. Well before it was funded by Google, the roots of
this initiative were being pioneered by a small group of people around the world
that were acting as local BIDS ambassadors in their communities. Many of us were
already giving presentations at every workshop and conference possible. However,
these were only for a limited audience, and there was a need for central
organization of these resources. We hoped to create a central repository
accessible to everyone that would contain easy to read documentation and a
collection of useful resources.

It was my responsibility over the Google Summer of Code to be the lead developer
and maintainer of the repository. When responding to requests from both senior
developers and new contributors alike, this meant breaking down requested
features into action items that could be assigned to either myself or the
relevant expert. Periodically, I would then go through the list of issues to
make sure progress on them did not “die out”. As a content creator, my work was
primarily focused on the README and wiki. This included writing content and
enhancing user experience by designing a clear framework. Although much of this
work was documentation, I had to be able to understand the specification to a
high technical standard - including the
[BIDS Apps software](http://bids-apps.neuroimaging.io/apps/) that are built from
docker images - in order to communicate the information to new users.

## Problem definitions and solutions

The title of this project was called Easy BIDS: Starter Kit, and that’s exactly
the question that we started with:

How do we make this data standard easier to adopt?

From there, we broke it down into a series of more discrete problems.

<br>

:o: **Problem** Which parts of BIDS are people finding most difficult?

:heavy_check_mark: **Solution** Through both formal surveys and informal chats,
I got feedback from the newcomers to BIDS. The results showed that people were
most confused by the technical jargon and metadata file formats.

<br>

:o: **Problem** The technical documentation about BIDS can be overwhelming.

:heavy_check_mark: **Solution** I developed an easy to read reference called the
[BIDS Starter Kit Wiki](https://github.com/bids-standard/bids-starter-kit/wiki).
What started as a two page document quickly grew into a compilation of
information, tutorials, examples, a glossary, publications, community resources,
and many more.

<br>

:o: **Problem** Engage more users

:heavy_check_mark: **Solution** In person, our team continued to spread the word
about the project during any relevant events. Online, we created an
[animated video](https://camo.githubusercontent.com/aada478abaddf957a3622589a5c370f11bf67642/687474703a2f2f696d672e796f75747562652e636f6d2f76692f425964686a5675427347302f302e6a7067)
to summarize the general idea and make the first step that much easier. We
developed
[extensive contribution guidelines](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md)
to help new contributors add their expertise to the project. We include how to
[get in touch](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md#get-in-touch),
[write in markdown](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md#writing-in-markdown),
[submit a pull request](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md#making-a-change-with-a-pull-request)
and explanations of where to put
[useful code or links in the wiki](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md#where-to-start-wiki-code-and-templates).
The licence on our repository is CC-BY and these guidelines have already been
incorporated into other open source neuroimaging projects such as
[NiBetaSeries](https://nibetaseries.readthedocs.io/en/stable/). We also used the
[“good-first-issue” principle](https://github.com/bids-standard/bids-starter-kit/blob/main/CONTRIBUTING.md#where-to-start-issue-labels)
to periodically leave small mistakes in our repository unfixed, such as a typo
or an undefined term in the glossary. Then, we would send out a request and
guide a new contributor through the process of using the repository.

As a result, the number of unique visitors grew from less than 5 to peaks of
over 50 per day.

<br>

:o: **Problem** International project management and communication

:heavy_check_mark: **Solution** The members of this project were located in
Canada ([Elizabeth DuPre](https://github.com/emdupre)), Britain
([Kirstie Whitaker](https://github.com/KirstieJane)), the Netherlands
([Dora Hermes](https://github.com/dorahermes)), the USA
([Chris Gorgolewski](https://github.com/chrisgorgo) and
[Chris Holdgraf](https://github.com/choldgraf/)), as well as a collaborator from
India ([Madhur Tandon](https://github.com/madhur-tandon)). The strategy for this
problem was to work publicly and to demonstrate best practise in open source
project leadership. This meant rather than waiting until completion to share
something, we would continuously post our work in progress and incorporate
feedback. Specifically, Github milestones and “closing soon” tags on issues were
helpful to highlight weekly tasks and mark them for review.

Despite these strategies, I still felt that the turning point of the project was
in June when some of our team finally met in person at the
[Organization for Human Brain Mapping Hackathon](https://ohbm.github.io/hackathon2018/).
I was a recipient of a travel award ($500) for this event and it really made a
huge difference in my effectiveness as maintainer and content creator for BIDS
Starter Kit. Summarizing an unnecessary meeting into a message is efficient, but
familiarity is really important too.

## Personal notes

As my first foray into community development and international project handling,
the toughest part at first was definitely the uncertainty -- a document doesn’t
have errors and nobody leaves detailed feedback about why they _didn’t_ feel
welcomed. But I’m glad to have finally learned the natural continuation of what
happens as a tool reaches maturity. To every mentor, collaborator,
administrator, and user that has been a part of this project so far, thank you
for all the help and feel free to message because I’ll still be staying
involved!

<br>

Patrick J. Park

Senior undergraduate student in Electrical Engineering (BESc) at Western
University, Canada

Email: parkpatrickj@gmail.com

Github: [Park-Patrick](https://github.com/Park-Patrick)
