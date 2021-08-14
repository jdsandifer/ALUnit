# Contributing to ALUnit

Hi there! Interested in contributing to ALUnit? We'd love your help. ALUnit is an open source project, built one contribution at a time by users like you.

## Where to get help or report a problem

If you have a question about using ALUnit, start a discussion.
If you think you've found a bug within ALUnit or have a feature request, open an issue.
More resources are listed on our Help page.

## Ways to contribute

Whether you're a developer, a designer, or just a ALUnit devotee, there are lots of ways to contribute. Here's a few ideas:

Read through the documentation, and click the "improve this page" button, any time you see something confusing, or have a suggestion for something that could be improved.
Comment on some of the project's open issues. Have you experienced the same problem? Know a work around? Do you have a suggestion for how the feature could be better?
Find an open issue (especially those labeled help-wanted), and submit a proposed fix. If it's your first pull request, we promise we won't bite, and are glad to answer any questions.
Help evaluate open pull requests, by testing the changes locally and reviewing what's proposed.

## Submitting a pull request

### Pull requests generally

The smaller the proposed change, the better. If you'd like to propose two unrelated changes, submit two pull requests.
The more information, the better. Make judicious use of the pull request body. Describe what changes were made, why you made them, and what impact they will have for users.
Pull request are easy and fun. If this is your first pull request, it may help to understand GitHub Flow.
If you're submitting a code contribution, be sure to read the code contributions section below.

### Submitting a pull request via github.com

Many small changes can be made entirely through the github.com web interface.

1. Navigate to the file that you'd like to edit.
2. Click the pencil icon in the top right corner to edit the file
3. Make your proposed changes
4. Click "Propose file change"
5. Click "Create pull request"
6. Add a descriptive title and detailed description for your proposed change. The more information the better.
7. Click "Create pull request"

That's it! You'll be automatically subscribed to receive updates as others review your proposed change and provide feedback.

### Submitting a pull request via Git command line

1. Fork the project by clicking "Fork" in the top right corner of jdsandifer/ALUnit.
2. Clone the repository locally `git clone https://github.com/<your-username>/ALUnit`.
3. Create a new, descriptively named branch to contain your change `git checkout -b my-awesome-feature`.
4. Hack away, add tests. Not necessarily in that order.
5. Make sure everything still passes by running the tests (if available).
6. Push the branch up `git push origin my-awesome-feature`.
7. Create a pull request by visiting `https://github.com/<your-username>/ALUnit` and following the instructions at the top of the screen.

## Proposing updates to the documentation

We want the ALUnit documentation to be the best it can be. We've open-sourced our docs and we welcome any pull requests if you find it lacking.

## How to submit changes

You can find the documentation for ALUnit in the docs directory. See the section above, submitting a pull request for information on how to propose a change.

One gotcha, all pull requests should be directed at the master branch (the default branch).

## Code Contributions

Interesting in submitting a pull request? Awesome. Read on. There's a few common gotchas that we'd love to help you avoid.

## Tests and documentation

Any time you propose a code change, you should also include updates to the documentation and tests within the same pull request.

### Documentation

If your contribution changes any ALUnit behavior, make sure to update the documentation. Documentation lives in the docs folder. If the docs are missing information, please feel free to add it in. Great docs make a great project. Include changes to the documentation within your pull request.

### Tests

If you're creating a small fix or patch to an existing feature, a simple test is more than enough. You can usually copy/paste from an existing example in the tests folder.
If it's a brand new feature, you may need to create entirely new tests.
Once ALUnit is funtional, please use it to test as much as possible.

### Code contributions generally

ALUnit follows a styleguide found in `STYLE.md`. Please ensure all of your code, tests, and documentation follow it.

## A thank you

Thanks! Working on autolisp-unit should be fun. If you find any of this hard to figure out, let us know so we can improve our process or documentation!
