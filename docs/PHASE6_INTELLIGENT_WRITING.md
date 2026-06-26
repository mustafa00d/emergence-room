# Phase 6 — Intelligent Writing

## Capabilities

- CEFR writing prompts from A1 to C2.
- Sentence, paragraph, email, story, essay, and report tasks.
- Structured scoring for grammar, spelling, vocabulary, coherence, task achievement, style, and overall performance.
- Faithful corrected text and a separate improved version.
- Arabic explanations, strengths, next steps, and stronger vocabulary suggestions.
- Version history for revisions and progress comparison.

## API

```http
GET  /v1/writing/prompts
GET  /v1/writing/usage
GET  /v1/writing/submissions
POST /v1/writing/submissions
GET  /v1/writing/submissions/:submissionId
POST /v1/writing/submissions/:submissionId/revisions
```

## Security

- All endpoints require a verified Supabase JWT.
- User identity is never accepted from the request body.
- Provider credentials remain on the server.
- Learner text is treated as untrusted data; instructions embedded in it are ignored.
- OpenAI output is constrained by a strict JSON schema and validated again by the backend.
- AI accounting records are backend-only.

## Database

Migration: `202606260006_intelligent_writing.sql`

Tables:

- `writing_prompts`
- `writing_submissions`
- `writing_versions`
- `writing_feedback_items`
- `writing_ai_runs`

When `OPENAI_API_KEY` is unavailable or the provider fails, the service returns a deterministic local evaluation so the learner does not lose the submission.