# Todo — Design

## Overview

A single-page React app (`todo-webapp`) lets a signed-in user manage personal and shared todo lists. It calls a Ballerina backend (`todo-api`) for all reads and writes; the API owns list, item, and sharing data in a dedicated PostgreSQL database. Users sign in through Thunder (the platform IDP); the API trusts identity injected by the gateway from the validated token.

## Context (C1)

```mermaid
graph TD
  user[User]
  subgraph System["Todo"]
    webapp[Todo Web App]
    api[Todo API]
  end
  auth[Thunder Auth]

  user -->|browses, manages lists & items| webapp
  webapp -->|REST calls| api
  webapp -->|sign-in / OIDC| auth
  api -->|validates token| auth
```

## Domain model (ER)

```mermaid
erDiagram
  USER {
    string id
    string username
    string displayName
  }
  TODO_LIST {
    string id
    string name
    string ownerId
    datetime createdAt
  }
  TODO_ITEM {
    string id
    string listId
    string text
    date dueDate
    boolean completed
    datetime createdAt
    datetime updatedAt
  }
  LIST_COLLABORATOR {
    string listId
    string userId
    datetime addedAt
  }

  USER ||--o{ TODO_LIST : owns
  TODO_LIST ||--o{ TODO_ITEM : contains
  TODO_LIST ||--o{ LIST_COLLABORATOR : "shared with"
  USER ||--o{ LIST_COLLABORATOR : collaborates
```

## Key flows

### Create a list and add an item

```mermaid
sequenceDiagram
  actor U as User
  participant W as Todo Web App
  participant A as Todo API
  U->>W: Create list "Groceries"
  W->>A: POST /todo-lists
  A-->>W: 201 Created (list)
  U->>W: Add item "Buy milk", due Fri
  W->>A: POST /todo-lists/{listId}/todo-items
  A-->>W: 201 Created (item)
  W-->>U: Item appears in list, sorted by due date
```

### Share a list with a collaborator

```mermaid
sequenceDiagram
  actor Owner
  participant W as Todo Web App
  participant A as Todo API
  actor Collaborator
  Owner->>W: Share list with "collaborator@org"
  W->>A: POST /todo-lists/{listId}/collaborators
  A-->>W: 201 Created (collaborator)
  Collaborator->>W: Sign in, open "Shared with me"
  W->>A: GET /todo-lists?scope=shared
  A-->>W: 200 OK (shared lists)
  Collaborator->>W: Add/complete item on shared list
  W->>A: PATCH /todo-lists/{listId}/todo-items/{itemId}
  A-->>W: 200 OK (updated item)
```

### Owner removes a collaborator / collaborator leaves

```mermaid
sequenceDiagram
  actor Owner
  participant W as Todo Web App
  participant A as Todo API
  actor Collaborator
  Owner->>W: Remove collaborator from list
  W->>A: DELETE /todo-lists/{listId}/collaborators/{userId}
  A-->>W: 204 No Content
  Collaborator->>W: Leave a list shared with them
  W->>A: DELETE /todo-lists/{listId}/collaborators/me
  A-->>W: 204 No Content
```