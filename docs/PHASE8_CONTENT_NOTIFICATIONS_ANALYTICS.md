# Phase 8 — Content CMS, Notifications, and Analytics

## Versioned content workflow

The live learner catalog remains in `learning_catalog_items`. Every edit is stored in `content_revisions` and follows this workflow:

```text
draft → in_review → approved → published
          ↘ changes_requested
published → archived
```

Publishing validates the lesson again and atomically replaces the live catalog payload. Existing lesson sessions remain stable because they already store a content snapshot.

## In-app notifications

The system supports campaigns for all learners, selected CEFR levels, roles, inactive learners, and learners with due vocabulary reviews. Campaigns can be sent immediately or scheduled. User preferences are applied before delivery.

## Analytics

Administrative endpoints report registration-to-learning conversion, daily engagement, feature use, CEFR skill distribution, and content starts, completions, completion rate, average score, and average duration.

## Database

Migration: `202606260008_content_cms_notifications_analytics.sql`

Tables:

- `content_revisions`
- `content_review_comments`
- `content_publication_events`
- `notification_campaigns`
- `user_notifications`
- `notification_preferences`

All content and campaign mutations require both a verified Supabase JWT and the administrative role. User notification records can only be read by their owner through RLS; mutations are performed by the authenticated backend.