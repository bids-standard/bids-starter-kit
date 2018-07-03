# Contributing to the BIDS Starter Kit

:tada::balloon::cake: **Welcome to the BIDS Starters Kit repository!** :cake::balloon::tada:

:dizzy::hatched_chick::sunny: *We're so excited you're here and want to contribute.* :sunny::hatched_chick::dizzy:

The point of this starter kit is to **welcome new users and contributors to the BIDS community**. We hope that these guidelines are designed to make it as easy as possible to get involved. If you have any questions that aren't discussed below, please let us know through one of the many ways to [get in touch](#get-in-touch).

## Table of contents

* [Joining the BIDS community](#joining-the-community)
* [Get in touch](#get-in-touch)
* [Contributing through GitHub](#contributing-through-github)
* [Where to start: wiki, code and templates](#where-to-start-wiki-code-and-templates)
* [Where to start: labels](#where-to-start-labels)
* [Make a change with a pull request](#making-a-change-with-a-pull-request)
* [Recognizing contributions](#recognizing-contributions)


## Joining the community

BIDS - the [Brain Imaging Data Structure][bids] - is a growing community of neuroimaging enthusiasts, and we want to make our resources accessible to and engaging for as many researchers as possible.

We therefore require that all contributions **adhere to our [Code of Conduct](CODE_OF_CONDUCT.md)**.

How do you know that you're a member of the BIDS community? You're here! You know that BIDS exists! You're officially a member of the community. It's THAT easy! Welcome! :joy::raised_hands:


## Get in touch

There are lots of ways to get in touch with the team maintaining the BIDS Starter Kit.

* Our channel in the [BrainHack slack team][brainhack-slack-starterkit]
  * Click [here][brainhack-slack-invite] for an invite to the slack workspace
* Our [Gitter channel][gitter]
* The [BIDS mailing list][bids-mailinglist]

If you're here during summer 2018 :icecream::palm_tree:, you should reach out to our lovely [Google Summer of Code][gsoc] student [Patrick Park][patrick-github]. He'll be monitoring all the channels above and it would really help his project along if you said hello and passed along any feedback you have :purple_heart:.

<img align="right" width="50%" src="https://linuxcentro.com.br/wp-content/uploads/2017/04/github-520x350.jpg" alt="Two github cats working together"/>

## Contributing through GitHub

[git][git] is a really useful tool for version control. [GitHub][github] sits on top of git and supports collaborative and distributed working.

We know that it can be daunting to start using git and GitHub if you haven't worked with them in the past, but the BIDS Starter Kit maintainers are here to help you figure out any of the jargon or confusing instructions you encounter! :heart:

In order to contribute via GitHub you'll need to set up a free account and sign in. Here are some [instructions](https://help.github.com/articles/signing-up-for-a-new-github-account/) to help you get going. Remember that you can ask us any questions you need to along the way.

## Writing in markdown

GitHub has a helpful page on [getting started with writing and formatting on GitHub](https://help.github.com/articles/getting-started-with-writing-and-formatting-on-github).

Most of the writing that you'll do will be in [Markdown][markdown]. You can think of Markdown as a few little symbols around your text that will allow GitHub to render the text with a little bit of formatting. For example you could write words as **bold**, or in *italics*, or as a [link][rick-roll] to another webpage.

## Where to start: wiki, code and templates

#### [Wiki][bids-starterkit-wiki]

We hope that the easiest place to find information about BIDS is the [**starter kit wiki**][bids-starterkit-wiki].

You only need to be logged in to GitHub to edit the wiki. So, there's no need for a pull request if you just want to fix a typo or add a useful link!

Here's a useful [introduction to GitHub wikis][intro-github-wiki]. Have a read through the pages that already exist in the wiki and please EDIT AWAY! :muscle::boom::sparkles:

#### [Code][bids-starterkit-repo]

This repository is under development, but we hope that it becomes a useful place for people to share and find small snippets of code that are useful for getting started with BIDS.

To contribute to the codebase you'll need to submit a pull request. Check out our [guidelines](#making-a-change-with-a-pull-request) below.

#### [Templates][bids-starterkit-repo]

This repository is under development, but we aim to have two templates for each BIDS sidecar file: one with a full example (all required/recommended/optional fields), and one with a minimal example (only required fields).

To contribute a template you'll need to submit a pull request. Check out our [guidelines](#making-a-change-with-a-pull-request) below.

## Where to start: labels

<!--
  COMMENTED OUT BY KW because she's changed the sentence below!
  ******* NEED TO CHECK W EMDP *******
  The list of labels for current issues are the same as for the BIDS [here][bids-starterkit-labels] and include:
-->
The list of labels for current issues can be found [here][bids-starterkit-labels] and includes:

* ![Help Wanted](https://img.shields.io/badge/-help%20wanted-159818.svg) *These issues contain a task that a member of the team has determined we need additional help with.*

    If you feel that you can contribute to one of these issues, we especially encourage you to do so!

* ![Requests](https://img.shields.io/badge/-requests-fbca04.svg) *These issues are asking for new features to be added to the project.*

    Please try to make sure that your requested feature is distinct from any others that have already been requested or implemented. If you find one that's similar but there are subtle differences please reference the other request in your issue.

## Making a change with a pull request

We appreciate all contributions to the BIDS Starter Kit. **THANK YOU** for helping us build this useful resource. :sparkles::star2::dizzy:

:point_right: Remember that if you're adding information to the [wiki](#wiki) you ***don't need to submit a pull request***. You can just log into GitHub, navigate to the [wiki][bids-starterkit-wiki] and click the **edit** button.

If you're updating the [code](#code) or the [templates](#templates), the following steps are a guide to help you contribute in a way that will be easy for everyone to review and accept with ease  :sunglasses:.

#### 1. Comment on an existing issue or open a new issue referencing your addition

This allows other members of the BIDS Starter Kit team to confirm that you aren't overlapping with work that's currently underway and that everyone is on the same page with the goal of the work you're going to carry out.

[This blog][dont-push-pull-request] is a nice explanation of why putting this work in up front is so useful to everyone involved.

#### 2. [Fork][github-fork] the [BIDS Starter Kit repository][bids-starterkit-repo] to your profile

This is now your own unique copy of the BIDS Starter Kit. Changes here won't affect anyone else's work, so it's a safe space to explore edits to the code!

Make sure to [keep your fork up to date][github-syncfork] with the master repository, otherwise you can end up with lots of dreaded [merge conflicts][github-mergeconflicts]. 

#### 3. Make the changes you've discussed

Try to keep the changes focused. If you submit a large amount of work in all in one go it will be much more work for whomever is reviewing your pull request. [Help them help you][jerry-maguire] :wink:

If you feel tempted to "branch out" then please make a [new branch][github-branches] and a [new issue][bids-starterkit-issues] to go with it.

#### 4. Submit a [pull request][github-pullrequest]

A member of the BIDS Starter Kit team will review your changes to confirm that they can be merged into the main codebase.

A [review][github-review] will probably consist of a few questions to help clarify the work you've done. Keep an eye on your github notifications and be prepared to join in that conversation.

You can update your [fork][github-fork] of the BIDS Starter Kit [repository][bids-starterkit-repo] and the pull request will automatically update with those changes. You don't need to submit a new pull request when you make a change in response to a review.

GitHub has a [nice introduction][github-flow] to the pull request workflow, but please [get in touch](#get-in-touch) if you have any questions :balloon:.


## Recognizing contributions

BIDS follows the [all-contributors][all-contributors] specification, so we welcome and recognize all contributions from documentation to testing to code development. You can see a list of current contributors in the [BIDS specification][bids-specification].

## Thank you!

You're awesome. :wave::smiley:

<br>

*&mdash; Based on contributing guidelines from the [STEMMRoleModels][stemm-role-models] project.*

[all-contributors]: https://github.com/kentcdodds/all-contributors#emoji-key
[bids]: http://bids.neuroimaging.io
[bids-specification]: https://docs.google.com/document/d/1HFUkAEE-pB-angVcYe6pf_-fVf4sCpOHKesUvfb8Grc/edit#heading=h.hds2i7ii7hjo
[bids-mailinglist]: https://groups.google.com/forum/#!forum/bids-discussion
[bids-starterkit-labels]: https://github.com/INCF/bids-starter-kit/labels
[bids-starterkit-repo]: https://github.com/INCF/bids-starter-kit
[bids-starterkit-wiki]: https://github.com/INCF/bids-starter-kit/wiki
[brainhack-slack-starterkit]: https://brainhack.slack.com/messages/C8RG7F6PN
[brainhack-slack-invite]: https://brainhack-slack-invite.herokuapp.com
[intro-github-wiki]: https://help.github.com/articles/about-github-wikis
[dont-push-pull-request]: https://www.igvita.com/2011/12/19/dont-push-your-pull-requests
[git]: https://git-scm.com
[github]: https://github.com
[github-branches]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository
[github-fork]: https://help.github.com/articles/fork-a-repo
[github-flow]: https://guides.github.com/introduction/flow
[github-mergeconflicts]: https://help.github.com/articles/about-merge-conflicts
[github-pullrequest]: https://help.github.com/articles/creating-a-pull-request
[github-review]: https://help.github.com/articles/about-pull-request-reviews
[github-syncfork]: https://help.github.com/articles/syncing-a-fork
[gitter]: https://gitter.im/INCF/bids-starter-kit
[gsoc]: https://summerofcode.withgoogle.com
[jerry-maguire]: http://gph.is/1ULS704
[markdown]: https://daringfireball.net/projects/markdown
[patrick-github]: https://github.com/Park-Patrick
[rick-roll]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[stemm-role-models]: https://github.com/KirstieJane/STEMMRoleModels
