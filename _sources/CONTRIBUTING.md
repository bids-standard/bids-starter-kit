# Contributing

🐣 **We're so excited you're here and want to contribute.** 🐣

The point of this starter kit is to **welcome new users and contributors to the BIDS community**.
We hope that these guidelines are designed to make it as easy as possible to get involved.
If you have any questions that aren't discussed below,
please let us know through one of the many ways to [get in touch](https://bids.neuroimaging.io/contact/).

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

### Matlab / Octave

We are using the Miss_hit linter to help us keep out matlab "clean".
You can find more information on how to set it up and use it on the bids-matlab
[contributing guidelines](https://github.com/bids-standard/bids-matlab/blob/master/CONTRIBUTING.md#matlab-code-style-guide-and-quality).

### Templates

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

<br>

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
