# Phase 5 — Speaking, Authentication, and Administration

## Database

Migration: `202606260005_speaking_and_admin.sql`

Tables:

- `user_roles`
- `speaking_prompts`
- `speaking_sessions`
- `speaking_attempts`
- `roleplay_turns`
- `admin_audit_logs`

The administrative user always retains the `learner` role, so one account can both monitor the system and complete learning activities.

## Speaking modes

- Guided read-aloud with word-level feedback.
- Shadowing with model audio and timing feedback.
- Multi-turn role-play with a configurable AI provider and a deterministic local fallback.

Provider modes:

- `openai_azure`: OpenAI transcription plus Azure pronunciation assessment.
- `azure`: transcript hint/local transcript plus Azure assessment.
- `openai_heuristic`: OpenAI transcription plus deterministic fallback scoring.
- `heuristic`: local development fallback.

Provider secrets stay on the server. They are never included in Flutter or returned by the API.

## Authentication

The Flutter application supports email/password sign-up, email confirmation resend, sign-in, sign-out, password recovery, and secure password replacement through a recovery deep link.

## Administration

Protected endpoints:

```http
GET /v1/admin/me
GET /v1/admin/overview
GET /v1/admin/users?limit=30
```

Both `SupabaseAuthGuard` and `AdminGuard` are required. Administrative reads are recorded in `admin_audit_logs`.

## Secure admin bootstrap

`backend/scripts/bootstrap-admin.ts` creates or promotes one Supabase Auth user and synchronizes the application roles in PostgreSQL. It does not print or commit the password. The GitHub workflow reads `ADMIN_EMAIL` and `ADMIN_PASSWORD` only from repository secrets.