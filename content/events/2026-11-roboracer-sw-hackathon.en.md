---
title: "RoboRacer SW Hackathon 2026"
date: 2026-11-16
draft: false
description: "An online hackathon by the IEEE ITSS Korea Chapter and Chungbuk National University: implement software for an autonomous racing car (F1TENTH) and compete on simulated lap time. Registration closes November 11, 2026 (Wed) 23:59 KST; award ceremony November 25 (Wed) at about 11:00 at Chungbuk National University."
event_date: "November 16 (Mon) – November 23 (Mon), 2026, online · award ceremony November 25 (Wed), about 11:00"
location: "Online (award ceremony at Chungbuk National University)"
---

**RoboRacer SW Hackathon 2026** (SW = software)

The IEEE ITSS Korea Chapter and Chungbuk National University are jointly holding the RoboRacer SW Hackathon 2026. Teams implement the software of an autonomous racing car (F1TENTH), qualify through automatic grading, and are ranked by their simulated lap time. The competition is online. The full announcement, the rules, and the AI tutor's feedback are in Korean; this page is a summary in English, and the [Korean page](https://ieee-itss-korea.github.io/web/ko/events/2026-11-roboracer-sw-hackathon/) is the full text.

> **Registration closes: November 11, 2026 (Wed), 23:59 KST.** Please submit the [registration form (Google Form)](https://forms.gle/chtypdJy2w8ALTcC9) before the deadline.

<!--more-->

## Event Details

| | |
|---|---|
| **Format** | Online hackathon. All teams start at the same time, and code committed to the team's GitHub repository is graded automatically. |
| **Registration** | [Google Form](https://forms.gle/chtypdJy2w8ALTcC9), until November 11 (Wed), 23:59 KST |
| **Competition period** | Starts Monday, November 16, 10:00; submission deadline Monday, November 23, 23:59 |
| **Award ceremony** | Wednesday, November 25, at about 11:00, Chungbuk National University |
| **Eligibility** | Open to anyone. IEEE ITSS membership is not required (joining is encouraged, not a condition). |
| **Teams** | 1 to 3 members; one person can join only one team |
| **Awards** | Prizes follow the ranking; winning teams receive a certificate in the name of the IEEE ITSS Korea Chapter. Every member of a team that pushed before the deadline and received a grading result gets a participation certificate, sent to the email on the registration form by November 25. |
| **Hosts** | IEEE ITSS Korea Chapter and Chungbuk National University |
| **Contact** | [Contact form](https://forms.gle/zFyReJdxHULLFrEY8) |

## Key Dates

| | |
|---|---|
| **Nov 11 (Wed), 23:59** | Registration closes |
| **Nov 12 (Thu)** | GitHub organization invitations are sent to all applicants at once |
| **Nov 15 (Sun), 23:59** | Deadline to accept the invitation (3 days from receiving it). An invitation not accepted by then is treated as withdrawal. |
| **Nov 16 (Mon), 10:00** | Competition starts (all teams at the same time) |
| **Nov 23 (Mon), 23:59** | Submission deadline |
| **Nov 24 (Tue)** | Ranking confirmed (the code of the top 3 teams is checked); winning teams are contacted individually |
| **Nov 25 (Wed), about 11:00** | Award ceremony at Chungbuk National University |

## Tasks

- **Lab 02: AEB safety node.** Compute the time to collision (TTC) from lidar range data and stop the car when it is dangerous. Passing all 11 automatic checks is the condition for being ranked.
- **Lab 04: Follow the Gap.** Drive through a corridor with obstacles using only lidar, without a collision. A simulated run that issues commands, reaches the end, and has no collision is a normal finish; the ranking uses the completion time (lap time) of the teams that finish normally. Other checks (code structure, units, style) are feedback only and do not count toward qualification or ranking.
- **Lab 04 simulator limits (competition rule):** top speed 6 m/s, acceleration 4 m/s^2, steering angle +-24 degrees, and a steering-speed limit. A command beyond a limit is clipped to the limit with no penalty. A run ends at the first collision. These limits will not be changed after the announcement.

## How to Take Part

1. Submit the [registration form](https://forms.gle/chtypdJy2w8ALTcC9) by November 11, 23:59: team name, member names, affiliations, emails, GitHub accounts, and the email linked to each GitHub account. The team name is used in the GitHub repository name: lowercase English letters, digits, and hyphens, 3 to 30 characters. Entering alone, the team name can be left blank (the GitHub account name is used).
2. After registration closes, an invitation to the GitHub organization (itss-korea-roboracer-2026) is sent to the GitHub account on the form. Accept it by November 15, 23:59. The invitation goes to the email registered on the GitHub account, not the email on the form, and may be sorted into spam.
3. At the start time, a repository is created for each team. It is private: only the team and the organizers can see it.
4. Commit to the `main` branch of the repository. Automatic grading runs, and the result appears on the commit as a score (Lab 02: Score N/11, Lab 04: Score N/14), usually within a few minutes. You can fix and push again without a limit. An unchanged template scores 6/11 on Lab 02 and 6/14 on Lab 04, so that is the starting point.
5. The deadline is November 23, 23:59. The best result among the pushes made before the deadline is counted, repository by repository, even if the grading result appears after the deadline. Pushes after the deadline are not counted. Grading takes a few minutes, so leave a margin.

## Ranking

- **Qualification:** only teams that pass all 11 checks of Lab 02 and finish Lab 04 normally are ranked. Other teams still receive their grading results and the tutor's feedback.
- **Order:** among qualified teams, the shorter Lab 04 completion time (lap time) ranks first. For the same record, the team that pushed first ranks first, by the push time recorded on GitHub's servers.

## Rules in Brief

- Generative AI (LLMs), public documents, and open source may be used without limit.
- Copying another team's code is not allowed, and neither is making your own solution public before the deadline (public repositories, blogs, bulletin boards, group chats).
- Hard-coding the coordinates or the path of a specific map is not allowed; the code must read and react to the lidar values. The organizers check the code of the top 3 teams before the ranking is confirmed.
- The grading system is shared by all teams. Several pushes to the same repository in a short interval may leave the intermediate ones ungraded; the latest push is graded. Putting load on the system, for example by excessive repeated pushes, can lead to restricted write access to that team's repository.
- A confirmed violation means exclusion from the ranking.

## AI Tutor

After grading, an AI tutor may read the code and leave feedback in Korean in the repository's Issues. The tutor's explanations are for reference and can be wrong. The score is decided only by the automatic grading.

## Privacy in Brief

- The registration form collects name, affiliation, email, GitHub account, and the email linked to the GitHub account; the IEEE membership number is optional. They are used to confirm participation, send GitHub invitations, announce results, and issue prizes and participation certificates. Information generated during the competition (the code in the repositories, grading results, the tutor's feedback, push times) is processed for the same purposes.
- Responses, team repositories, and submitted code are deleted 30 days after the ceremony (around December 25, 2026); only team names and rankings remain. Participants can download their own work before then.
- Code submitted to the competition is sent to an external generative AI service to produce the AI tutor's feedback. The team name, member names, and affiliations of winning teams may be published on Chapter channels.
- Reuse of submitted code for improving the competition, education, and research applies only to teams that agreed in the optional consent item of the form, and only identity-free copies are kept, for up to 3 years. Not agreeing does not affect participation or ranking. The deletion schedule above still applies.
- The member list of the GitHub organization is visible only to the organization's own members, not to the public, and a team's repository cannot be seen by other teams.
- Section 8 of the [Korean page](https://ieee-itss-korea.github.io/web/ko/events/2026-11-roboracer-sw-hackathon/) is the full text; if this summary differs from it, the Korean text applies.

## Contact

IEEE ITSS Korea Chapter Chair, **Kangwon Lee** — [contact form](https://forms.gle/zFyReJdxHULLFrEY8). If nothing changes in your repository about 10 minutes after a commit (no score and no Issues post), please let us know: the cause may be our grading system, not your code.
