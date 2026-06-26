# Phase 7 — Vocabulary, Spelling, Morphology, and FSRS

## Capabilities

- CEFR vocabulary library from A1 to C2.
- Arabic and English definitions, IPA, examples, translations, synonyms, antonyms, and word families.
- Roots, prefixes, suffixes, morphology explanations, and spelling patterns.
- Four-grade flashcard reviews using the official `ts-fsrs` scheduler.
- Smart dictation using device text-to-speech, with server-side spelling evaluation.
- Morphology practice sessions and resumable progress.
- Seven-day review forecast, mastery state, XP, daily progress, and streak integration.

## API

```http
GET  /v1/vocabulary/dashboard
GET  /v1/vocabulary/words
POST /v1/vocabulary/words/:code/add
POST /v1/vocabulary/sessions
GET  /v1/vocabulary/sessions/:sessionId
POST /v1/vocabulary/sessions/:sessionId/answers
```

## Database

Migration: `202606260007_vocabulary_fsrs.sql`

Tables:

- `vocabulary_entries`
- `user_vocabulary_cards`
- `vocabulary_practice_sessions`
- `vocabulary_review_logs`

Each card persists the FSRS due date, stability, difficulty, state, learning steps, repetitions, lapses, scheduled interval, and last review date.

## Security and integrity

- Every endpoint requires a verified Supabase JWT.
- User identity is derived from the token, never the request body.
- Sessions and cards are ownership checked and locked during updates.
- Spelling and morphology answers are evaluated by the backend.
- Card scheduling, review logs, XP, streaks, and daily progress are committed atomically.