# Contributing

🐣 **We're so excited you're here and want to contribute.** 🐣

The point of this starter kit is to **welcome new users and contributors to the BIDS community**.
We hope that these guidelines are designed to make it as easy as possible to get involved.
If you have any questions that aren't discussed below,
please let us know through one of the many ways to [get in touch](#get-in-touch).

## Joining the community

BIDS - the [Brain Imaging Data Structure][bids] - is a growing community of neuroimaging enthusiasts,
and we want to make our resources accessible to and engaging for as many researchers as possible.

We therefore require that all contributions
**adhere to our [Code of Conduct](CODE_OF_CONDUCT.md)**.

How do you know that you're a member of the BIDS community?
You're here!
You know that BIDS exists!
You're officially a member of the community.
It's THAT easy! Welcome! 🙌 😂

## Get in touch

See out [contact page](contact.md) for all the ways to get in touch.

## Contributing through GitHub

[git][git] is a really useful tool for version control.
[GitHub][github] sits on top of git and supports collaborative and distributed working.

We know that it can be daunting to start using git and GitHub
if you haven't worked with them in the past,
but the BIDS Starter Kit maintainers are here to help you figure out
any of the jargon or confusing instructions you encounter! 💕

In order to contribute via GitHub you'll need to set up a free account and sign in.
Here are some
[instructions](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account)
to help you get going.
Remember that you can ask us any questions you need to along the way.

### Issue labels

The list of labels for current issues can be found
[here][bids-starterkit-labels] and includes:

-   [![help-wanted](https://img.shields.io/badge/-help%20wanted-159818.svg)][labels-helpwanted]
    _These issues contain a task that a member of the team has determined we need additional help with._

    If you feel that you can contribute to one of these issues,
    we especially encourage you to do so!

-   [![Question](https://img.shields.io/badge/-question-cc317c.svg)][labels-question]
    _These issues contain a question that you'd like to have answered._

    There are [lots of ways to ask questions](#get-in-touch)
    but opening an issue is a great way to start a conversation and get your answer.

-   [![good-first-issue](https://img.shields.io/badge/-good%20first%20issue-1b3487.svg)][labels-firstissue]
    _These issues are particularly appropriate if it is your first contribution to the BIDS Starter Kit, or to GitHub overall._

    If you're not sure about how to go about contributing,
    these are good places to start.
    You'll be mentored through the process by the maintainers team.
    If you're a seasoned contributor, please select a different issue
    to work from and keep these available for the newer
    and potentially more anxious team members.

-   [![Enhancement](https://img.shields.io/badge/-enhancement-84b6eb.svg)][labels-enhancement]
    _These issues are suggesting new features that can be added to the project._

    If you want to ask for something new,
    please try to make sure that your request is distinct from any others
    that are already in the queue (or part of the starter kit!).
    If you find one that's similar but there are subtle differences
    please reference the other enhancement in your issue.

-   [![Documentation](https://img.shields.io/badge/-documentation-ffd700.svg)][labels-documentation]
    _These issues relate to improving or updating the documentation._

    These are usually really great issues to help out with:
    our goal is to make it easy to understand BIDS
    without having to ask anyone any questions!
    Documentation is the ultimate solution 🏆

-   [![Community](https://img.shields.io/badge/-community-8605c1.svg)][labels-community]
    _These issues relate to building and supporting the BIDS community._

    BIDS won't work if people don't use the standard!
    YOU are the BIDS community, and we want to know how best to support you.

-   [![Bug](https://img.shields.io/badge/-bug-ee0701.svg)][labels-bug] _These
    issues are reporting a problem or a mistake in the project._

    The more details you can provide the better! If you know how to fix the bug,
    please open an issue first and then
    [submit a pull request](#making-a-change-with-a-pull-request) ✨

-   [![Closing Soon](https://img.shields.io/badge/-closing%20soon-ed6186.svg)][labels-closingsoon]
    _These issues are closing soon...get your opinions in asap!_

    This label is mostly used to indicate that an old issue is about to be closed,
    or that a final decision is going to be made on a long running discussion.
    Speak now....or open a new issue when this one is gone. 😜

-   [![Funding](https://img.shields.io/badge/-funding-55e0c2.svg)][labels-funding]
    _These issues relate to finding money money money to keep building the project_

    We'd love to hear about any opportunities for funding
    to keep building the BIDS Starter Kit 💰

-   [![Logistics](https://img.shields.io/badge/-logistics-deaefc.svg)][labels-logistics]
    _These issues relate to project management for the BIDS starter kit_

    We like to model best practice, so the BIDS Starter Kit itself is managed
    through these issues.
    We may occasionally have some to coordinate some logistics.

### Comment on an existing issue or open a new issue referencing your addition

This allows other members of the BIDS Starter Kit team to confirm
that you aren't overlapping with work that's currently underway
and that everyone is on the same page with the goal of the work you're going to carry out.

[This blog][dont-push-pull-request] is a nice explanation of why putting
this work in up front is so useful to everyone involved.

## Making a change with a pull request

We appreciate all contributions to the BIDS Starter Kit.

**THANK YOU** for helping us build this useful resource. ✨ 🌟 💫

If you're updating the [code](#code) or the [templates](#templates),
the following steps are a guide to help you contribute in a way that will be easy
for everyone to review and accept with ease 😎.

### Requirements

To make a contribution you will need to have:

-  a github account (see above)
-  python 3.8 or higher
-  a code editor like vs-code

To make edits you will need to:

- fork the bids-starter-kit repository
- clone your fork to your computer
- install the dependencies
- make changes
- push your changes to your fork
- submit a pull request

<!-- TODO

- explain how to install python

-->

### [Fork][github-fork] the [BIDS Starter Kit repository][bids-starterkit-repo] to your profile

This is now your own unique copy of the BIDS Starter Kit.
Changes here won't affect anyone else's work,
so it's a safe space to explore edits to the code!

Make sure to [keep your fork up to date][github-syncfork] with the upstream repository,
otherwise you can end up with lots of dreaded [merge conflicts][github-mergeconflicts].

### Clone your fork to your computer

```bash
git clone --recurse-submodules https://github.com/YOUR_USER_NAME/BIDS-Starter-Kit.git
```

### Install the dependencies and set up pre-commit hooks

```bash
pip install -r requirements_dev.txt
pre-commit install
```

### Make the changes you've discussed

Try to keep the changes focused.
If you submit a large amount of work in all in one go
it will be much more work for whomever is reviewing your pull request.
[Help them help you][jerry-maguire] 😉

If you feel tempted to "branch out" then please make
a [new branch][github-branches] and a [new issue][bids-starterkit-issues]
to go with it.

### Writing in markdown

GitHub has a helpful page on
[getting started with writing and formatting on GitHub](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github).

Most of the writing that you'll do will be in [Markdown][markdown].
You can think of Markdown as a few little symbols around your text
that will allow GitHub to render the text with a little bit of formatting.
For example you could write words as bold (`**bold**`),
or in italics (`*italics*`),
or as a [link][rick-roll] (`[link](https://https://youtu.be/dQw4w9WgXcQ)`)
to another webpage.

### Commit your changes

```bash
git add .
git commit -m "your commit message"
```

<!-- TODO explain how to deal with pre-commit -->

### view your changes

```bash
jupyter-book build src
```

This will build the book in the `src/_build` folder.
You can then open the `src/_build/html/index.html` file in your browser to view the changes.

### Submit a [pull request][github-pullrequest]

A member of the BIDS Starter Kit team will review your changes
to confirm that they can be merged into the main codebase.

A [review][github-review] will probably consist of a few questions to help
clarify the work you've done.
Keep an eye on your github notifications and be prepared to join in that conversation.

You can update your [fork][github-fork] of the BIDS Starter Kit
[repository][bids-starterkit-repo] and the pull request will automatically
update with those changes.
You don't need to submit a new pull request when you make a change in response to a review.

GitHub has a [nice introduction][github-flow] to the pull request workflow,
but please [get in touch](#get-in-touch) if you have any questions 🎈.

### Example pull request

<img align="right" src="https://i.imgur.com/s8yELfK.png" alt="Example-Contribution"/>

<br>

<br>

## Code ([link][bids-starterkit-repo])

This repository is under development,
but we hope that it becomes a useful place for people to share
and find small snippets of code that are useful
for getting started with BIDS.

To contribute to the codebase you'll need to submit a pull request.
Check out our [guidelines](#making-a-change-with-a-pull-request) below.

In general if you are contributing some code that requires some inputs,
either provide that input or a link on how to access it,
and an example on how to run that code.

### Matlab / Octave

We are using the Miss_hit linter to help us keep out matlab "clean".
You can find more information on how to set it up and use it on the bids-matlab
[contributing guidelines](https://github.com/bids-standard/bids-matlab/blob/master/CONTRIBUTING.md#matlab-code-style-guide-and-quality).

### Templates ([link][bids-starterkit-repo])

This repository is under development, but we aim to have two templates for each
BIDS sidecar file:

-   one with a `full` example (all required/recommended/optional fields),
-   one with a `short` example (only required fields).

If possible try to provide a script (python, octave, matlab)
to generate those templates.

Try to name your script as follow: `createBIDS_<suffix>_<extension>_*.[py|m]`

```
createBIDS_T1w_json_short.m
```

To contribute a template you'll need to submit a pull request.
Check out our [guidelines](#making-a-change-with-a-pull-request) below.


## Recognizing contributions

BIDS follows the [all-contributors][all-contributors] specification,
so we welcome and recognize all contributions from documentation
to testing to code development.
You can see a list of current contributors in the [BIDS specification][bids-specification].

## Thank you

You're awesome. 👋 😄

<br>

_&mdash; Based on contributing guidelines from the
[STEMMRoleModels][stemm-role-models] project._

[all-contributors]: https://github.com/kentcdodds/all-contributors#emoji-key
[bids]: http://bids.neuroimaging.io
[bids-specification]: https://bids-specification.readthedocs.io/en/latest/
[bids-mailinglist]: https://groups.google.com/forum/#!forum/bids-discussion
[bids-starterkit-issues]: https://github.com/bids-standard/bids-starter-kit/issues
[bids-starterkit-labels]: https://github.com/bids-standard/bids-starter-kit/labels
[bids-starterkit-repo]: https://github.com/bids-standard/bids-starter-kit
[bids-starterkit-book]: https://bids-standard.github.io/bids-starter-kit/
[brainhack-slack-starterkit]: https://brainhack.slack.com/messages/C8RG7F6PN
[brainhack-slack-invite]: https://brainhack-slack-invite.herokuapp.com
[dont-push-pull-request]: https://www.igvita.com/2011/12/19/dont-push-your-pull-requests
[git]: https://git-scm.com
[github]: https://github.com
[github-branches]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository
[github-fork]: https://docs.github.com/en/get-started/quickstart/fork-a-repo
[github-flow]: https://guides.github.com/introduction/flow
[github-mergeconflicts]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/about-merge-conflicts
[github-pullrequest]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request
[github-review]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews
[github-syncfork]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork
[gitter]: https://gitter.im/INCF/bids-starter-kit
[gsoc]: https://summerofcode.withgoogle.com
[labels-link]: https://github.com/bids-standard/bids-starter-kit/labels
[labels-bug]: https://github.com/bids-standard/bids-starter-kit/labels/bug
[labels-closingsoon]: https://github.com/bids-standard/bids-starter-kit/labels/closing%20soon
[labels-community]: https://github.com/bids-standard/bids-starter-kit/labels/community
[labels-documentation]: https://github.com/bids-standard/bids-starter-kit/labels/documentation
[labels-enhancement]: https://github.com/bids-standard/bids-starter-kit/labels/enhancement
[labels-firstissue]: https://github.com/bids-standard/bids-starter-kit/labels/good%20first%20issue
[labels-funding]: https://github.com/bids-standard/bids-starter-kit/labels/funding
[labels-helpwanted]: https://github.com/bids-standard/bids-starter-kit/labels/help%20wanted
[labels-logistics]: https://github.com/bids-standard/bids-starter-kit/labels/logistics
[labels-question]: https://github.com/bids-standard/bids-starter-kit/labels/question
[jerry-maguire]: https://media.giphy.com/media/uRb2p09vY8lEs/giphy.gif
[markdown]: https://daringfireball.net/projects/markdown
[neurostars-forum]: https://neurostars.org/tags/bids
[patrick-github]: https://github.com/Park-Patrick
[rick-roll]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[stemm-role-models]: https://github.com/KirstieJane/STEMMRoleModels
