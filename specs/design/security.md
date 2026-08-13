# Todo — Security Design

## Roles → permissions

The PRD defines a single actor, **User**, but a user's permissions on a given list depend on whether they own it or collaborate on it. Both are the same role (User) acting in a different relationship to a specific list — not separate actors.

No list is visible to a user who is neither its owner nor a collaborator — deny by default.

## Authentication (Thunder)

- Shared `platform-resource` dependency name: **`user-auth`** (resourceType `thunder-app`), declared identically on `todo-webapp` and `todo-api`.
- Scopes: `openid profile email` (default).
- `todo-webapp` performs OIDC + PKCE sign-in against Thunder and attaches the resulting access token to every call to `todo-api`.
- `todo-api` sits behind the gateway, which validates the token and injects the caller's identity (`X-User-Id` / `X-User-Name`) — `todo-api` never validates tokens itself.

## Role resolution

`todo-api` derives the caller's identity from the gateway-injected `X-User-Id` header on every request. For each list-scoped operation it looks up whether that user id is the list's `ownerId` or appears in `LIST_COLLABORATOR` for that list:

- Owner → full permissions on the list (rename/delete, manage collaborators, manage items).
- Collaborator → item-level permissions only (no rename/delete, no collaborator management), plus the ability to remove themselves (leave).
- Neither → the list does not exist from that caller's point of view; the API returns `404`, never `403`, to avoid confirming the list's existence.