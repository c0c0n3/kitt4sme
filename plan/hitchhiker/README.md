The Hitchhiker's Guide to the GitHub Project
--------------------------------------------
> The answer is not just 42, but also 3568!

We've got lots of dev activities going on in KITT4SME from design to
coding to writing tech docs, there's plenty to keep us busy. The bulk
of that comes from tasks in WP 2, 3 and 4, but WP 5, 6 and 8 also
contribute bits and pieces to the dev stream. So below is a short
intro to how we keep tabs on dev activities and get stuff done.
The GitHub project that helps us with that is at:

* https://github.com/users/c0c0n3/projects/1


### Iterative approach

A year into the project, we're all familiar with project objectives
and high-level features to be implemented to achieve them. But as we
go along we still break down and refine those high-level features
into more detailed and manageable chunks of work. We then implement
those low-level features in two-week iterations—a.k.a. "sprints".

A sprint starts with a "grooming" session on a Monday. (Dunno why
[this song][manic-mon.song] springs to mind.) We get together in this
session to decide what features to work on in the next two weeks and
flesh out high-level features. We pick features from the project backlog
according to priority—high-priority stuff gets done first, low-priority
items can be pushed back or moved to the next iteration. Each of us
walks out of the session with a handful of low-level tasks to implement—and
possibly a headache.

Each team implements and tests the low-level features assigned to
them. Sometimes even small features may need more thinking time, so
the team has to "shape" them before they can start coding. When done
with the implementation and testing, a victim gets selected to review
the code—or the docs if the task was about writing a technical piece.

The sprint ends two weeks later, on a Friday, with a show & tell and
a little retro. Everyone demos the good stuff they've worked on. Then
we talk about what worked well and what didn't and if our dev machine
cogs need some lube to do stuff better in the next iteration.


### Work breakdown structure

We've adopted a simple hierarchical structure to organise our work
into manageable chunks and keep our sanity. At the top sit the project
objectives we've got to achieve in the coming months. Each objective
groups the high-level features to be implemented to achieve it. In
turn, each high-level feature tracks all the smaller features needed
to deliver it. These low-level features are meant to be something a
person or two can comfortably work on during an iteration. Their content
usually gets fleshed out in grooming sessions and includes three small
sections:

- **Summary**. A couple of sentences to explain what the feature is
  about. The summary focuses on functionality, keeping the technical
  details out.
- **Intended outcome**. What's the end goal? What are the benefits?
- **How will it work?**. A sketch of the high-level flow, keeping out
  as many technical details as possible.

The visual below shows what all this looks like on GitHub. We set up
a [KITT4SME project][proj] with an [Objectives view][proj.obj] you
can use to drill down from high to low-level features. We use GitHub
issues to document features. High-level features have a title starting
with `[Tracking]` like [the one you see below][kl.47]. Low-level features
are just plain old GitHub issues like the [one on the right-hand side][ad.3]
of the visual which is tracked by [the one shown in the middle][kl.47].
Notice we link each issue to the accounts of the devs working on
it—"Assignees" field.

![Work breakdown structure on GitHub.][wbs.dia]

We also threw in a [Roadmap view][proj.rm] for good measure. The roadmap
basically contains the same info as the objectives view but the features
are grouped by milestone. Same same but different. No, honestly, the
idea is that this alternative arrangement of high-level features should
make it easy to get a sense of our dev plan.


### Tying features to the architecture

We attach GitHub labels to each issue to be able to tell how it relates
to the architecture—especially to the [cloud instance layers][arch.cloud].
In fact, we use these [labels][kl.lbl]:

* `AI / app services`. Platform application services.
* `infra`. Platform infrastructure services.
* `mesh`. Mesh infrastructure.
* `security`. Platform security.
* `hardware`. Hardware to run the platform.
* `RAMP`. Integration with the RAMP platform.
* `docs`. Improvements or additions to documentation.
* `bug`. Something isn't working. 
* `tracking`. Issue group to track progress of smaller chunks of work.

We attach the same labels to pull requests too so it's easy to find
all the items related to a particular architectural function. (Pull
requests are explained in the next section.) For example, here's a
screenshot of a GitHub search for all the items related to platform
infrastructure services.

![Finding all infra issues and PRs.][find-by-label]


### Tying features to the implementation

We use GitHub pull requests to track what it took to implement a feature,
who did the work and who reviewed it. A pull request (PR) is a proposal
for merging a change set into a repo. Typically a PR's change set
implements a single (low-level) feature, but occasionally it can implement
more than one. Each PR comes with a detailed technical description of
the code (or docs) changes and links back to the feature it implements.
GitHub automatically generates a diff for the change set so you can see
exactly what code got added, modified or deleted.

The visual below shows a typical KITT4SME PR on GitHub. As you can
see, the [PR][kl.84] links back to the [feature][kl.81] it implements
and contains a generous amount of technical explanations. Also notice
we link each PR to the accounts of the devs who worked on it as well
as the reviewers—"Assignees" and "Reviewers" field, respectively.

![GitHub pull request.][impl.dia]


### Running a sprint

**TODO**

![Sprint 2 at 03 Feb 2022.][proj.s2]




[ad.3]: https://github.com/c0c0n3/kitt4sme.anomaly/issues/3
[arch.cloud]: https://github.com/c0c0n3/kitt4sme/blob/master/arch/mesh/cloud.md
[find-by-label]: ./find-by-label.png
[impl.dia]: ./implementation.jpeg
[kl.47]: https://github.com/c0c0n3/kitt4sme.live/issues/47
[kl.81]: https://github.com/c0c0n3/kitt4sme.live/issues/81
[kl.84]: https://github.com/c0c0n3/kitt4sme.live/pull/84
[kl.lbl]: https://github.com/c0c0n3/kitt4sme.live/labels
[proj]: https://github.com/users/c0c0n3/projects/1
[proj.obj]: https://github.com/users/c0c0n3/projects/1/views/1
[proj.rm]: https://github.com/users/c0c0n3/projects/1/views/9
[proj.s2]: ./sprint2.03-feb-2022.png
[manic-mon.song]: https://youtu.be/SsmVgoXDq2w
[wbs.dia]: ./work-breakdown-structure.jpeg

