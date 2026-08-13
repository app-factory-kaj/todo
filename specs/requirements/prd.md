# todo — PRD

## Problem Statement

People juggle personal and shared tasks across sticky notes, chat threads, and memory, so things fall through the cracks. There is no single place to capture a task, give it a due date, group it with related work, and — when needed — share that group with someone else working on the same thing.

## Solution

A web-based todo app where each signed-in user organizes tasks into named lists. Each todo item carries text and an optional due date. Lists can be shared with other users so a list's todos can be worked on together, while lists that are never shared stay private to their owner.

## Actors

- **User**: any person signed in through the organization's SSO. Creates and manages their own todo lists and items, and can share a list with other users to collaborate on it.

## User Stories

1. As a User, I want to sign in with my organization account, so that my todos are mine and nobody else's by default.
2. As a User, I want to create a named todo list, so that I can organize my tasks into separate collections.
3. As a User, I want to rename or delete a todo list I own, so that I can keep my collections accurate.
4. As a User, I want to add a todo item with text and an optional due date to a list, so that I can capture what needs doing and when.
5. As a User, I want to edit a todo item's text or due date, so that I can keep it accurate as things change.
6. As a User, I want to mark a todo item as complete or incomplete, so that I can track progress.
7. As a User, I want to delete a todo item, so that I can remove tasks that no longer matter.
8. As a User, I want to view the todos in a list sorted by due date, so that I can see what's coming up first.
9. As a User, I want to see all my lists at a glance with a count of open items in each, so that I can pick what to focus on.
10. As a User, I want to share a list I own with another user, so that we can collaborate on the same set of todos.
11. As a User, I want to see who a shared list is shared with, so that I know who else can see and edit it.
12. As a User, I want to remove a collaborator from a list I own, so that I can control who has access.
13. As a User, I want to see the lists shared with me by others alongside my own lists, so that I have one place to work from.
14. As a User, I want to leave a list that was shared with me, so that I can stop collaborating on it without affecting the owner or other collaborators.

## Product Decisions

- Sign-in is via SSO through Thunder, the platform IDP (org default).
- A todo list has exactly one owner (its creator); the owner controls sharing and can delete the list. Anyone the list is shared with is a collaborator.
- Collaborators on a shared list can view and edit its todo items (add, edit, complete, delete) but cannot rename/delete the list or manage its sharing — only the owner can. *assumed*
- Todo items support free-text description and an optional due date; grouping is by list rather than free-form tags.
- No reminder or notification channel (email, push, etc.) is part of this product — users track due dates by checking the app themselves.
- No external service integrations are required beyond the organization's standard sign-in.

## Phasing

- **Phase 1 — a working shared todo app**: users sign in, manage lists and todo items with due dates, and share lists with collaborators. Stories: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14.

## Out of Scope

- Reminders or notifications (email, push, SMS) for upcoming or overdue todos.
- Recurring or repeating todo items.
- Per-item sharing or permission levels finer than owner/collaborator.
- Activity history or audit log of changes to a list.
- Native mobile apps (this is a web app only).
- Task assignment to a specific collaborator within a shared list.

## Open Questions

None — the decisions above resolve every point raised so far.