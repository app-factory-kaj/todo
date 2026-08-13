// Todo web app — 4 screens: lists overview, list detail, new list, sharing

screen ListsOverview "Signed-in user sees own and shared lists at a glance"
  navbar "Todo"
  sidebar "My Lists -> ListsOverview | Shared With Me -> ListsOverview | Settings"
  row
    heading "Your Lists"
    right
    search "Search lists…"
    button "New list" primary -> NewList
  row
    card "Total lists | 5 | 3 owned, 2 shared"
    card "Open items | 12 | across all lists"
    card "Due this week | 4 | across all lists"
  heading "My Lists"
  table "List | Open items | Role | Updated" -> ListDetail
    row "Groceries | 3 | Owner | 2h ago"
    row "Home Renovation | 6 | Owner | 1d ago"
    row "Q3 Planning | 3 | Owner | 3d ago"
  heading "Shared With Me"
  table "List | Open items | Owner | Updated" -> ListDetail
    row "Trip to Kyoto | 5 | J. Alvarez | 5h ago"
    row "Book Club Reads | 2 | M. Chen | 2d ago"

screen NewList "User creates a new named todo list"
  navbar "Todo"
  sidebar "My Lists -> ListsOverview | Shared With Me -> ListsOverview | Settings"
  breadcrumb "Lists / New list"
  heading "New List"
  input "List name — e.g. Groceries"
  row
    right
    button "Cancel" -> ListsOverview
    button "Create list" primary -> ListDetail

screen ListDetail "Owner or collaborator manages items and due dates in one list"
  navbar "Todo"
  sidebar "My Lists -> ListsOverview | Shared With Me -> ListsOverview | Settings"
  breadcrumb "Lists / Groceries"
  row
    heading "Groceries"
    badge "Owner" info
  text "3 open of 8 items — sorted by due date"
  split 60/40
    left
      row
        input "Add a todo…"
        select "Due date: none"
        button "Add" primary
      table "Done | Item | Due | Status"
        row "[ ] | Buy milk | Fri | Open"
        row "[ ] | Book plumber | Mon | Open"
        row "[x] | Order paint | — | Done"
      row
        right
        button "Edit item"
        button "Delete item"
    right
      card "Shared with"
        text "J. Alvarez — added 3d ago"
        text "M. Chen — added 1d ago"
        button "Manage sharing" -> ManageSharing

screen ManageSharing "List owner adds or removes collaborators on a list they own"
  navbar "Todo"
  sidebar "My Lists -> ListsOverview | Shared With Me -> ListsOverview | Settings"
  breadcrumb "Lists / Groceries / Sharing"
  heading "Sharing — Groceries"
  row
    input "Add collaborator by username…"
    button "Share" primary
  table "Collaborator | Added | Action"
    row "J. Alvarez | 3d ago | Remove"
    row "M. Chen | 1d ago | Remove"
  row
    right
    button "Done" primary -> ListDetail
