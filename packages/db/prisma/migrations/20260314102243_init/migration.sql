-- CreateTable
CREATE TABLE "repositories" (
    "id" TEXT NOT NULL,
    "github_repository_id" BIGINT NOT NULL,
    "owner" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "description" TEXT,
    "default_branch" TEXT,
    "primary_language" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "repositories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "raw_events" (
    "id" TEXT NOT NULL,
    "github_event_id" TEXT NOT NULL,
    "repository_id" TEXT NOT NULL,
    "ingestion_run_id" TEXT,
    "event_type" TEXT NOT NULL,
    "actor_login" TEXT,
    "occurred_at" TIMESTAMP(3) NOT NULL,
    "payload" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "raw_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "repository_daily_metrics" (
    "id" TEXT NOT NULL,
    "repository_id" TEXT NOT NULL,
    "metric_date" DATE NOT NULL,
    "watch_events" INTEGER NOT NULL DEFAULT 0,
    "fork_events" INTEGER NOT NULL DEFAULT 0,
    "issue_events" INTEGER NOT NULL DEFAULT 0,
    "pull_request_events" INTEGER NOT NULL DEFAULT 0,
    "pull_request_review_comment_events" INTEGER NOT NULL DEFAULT 0,
    "push_events" INTEGER NOT NULL DEFAULT 0,
    "create_events" INTEGER NOT NULL DEFAULT 0,
    "score" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "repository_daily_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "repository_weekly_metrics" (
    "id" TEXT NOT NULL,
    "repository_id" TEXT NOT NULL,
    "week_start_date" DATE NOT NULL,
    "watch_events" INTEGER NOT NULL DEFAULT 0,
    "fork_events" INTEGER NOT NULL DEFAULT 0,
    "issue_events" INTEGER NOT NULL DEFAULT 0,
    "pull_request_events" INTEGER NOT NULL DEFAULT 0,
    "pull_request_review_comment_events" INTEGER NOT NULL DEFAULT 0,
    "push_events" INTEGER NOT NULL DEFAULT 0,
    "create_events" INTEGER NOT NULL DEFAULT 0,
    "score" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "repository_weekly_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "keyword_daily_metrics" (
    "id" TEXT NOT NULL,
    "keyword" TEXT NOT NULL,
    "metric_date" DATE NOT NULL,
    "repository_count" INTEGER NOT NULL DEFAULT 0,
    "total_score" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "keyword_daily_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "generated_summaries" (
    "id" TEXT NOT NULL,
    "repository_id" TEXT,
    "subject_type" TEXT NOT NULL,
    "subject_key" TEXT NOT NULL,
    "window" TEXT NOT NULL,
    "summary_date" DATE NOT NULL,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "generated_summaries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ingestion_runs" (
    "id" TEXT NOT NULL,
    "source" TEXT NOT NULL DEFAULT 'github',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "cursor" TEXT,
    "started_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completed_at" TIMESTAMP(3),
    "events_fetched" INTEGER NOT NULL DEFAULT 0,
    "events_stored" INTEGER NOT NULL DEFAULT 0,
    "error_message" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ingestion_runs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "repositories_github_repository_id_key" ON "repositories"("github_repository_id");

-- CreateIndex
CREATE UNIQUE INDEX "repositories_full_name_key" ON "repositories"("full_name");

-- CreateIndex
CREATE UNIQUE INDEX "repositories_owner_name_key" ON "repositories"("owner", "name");

-- CreateIndex
CREATE UNIQUE INDEX "raw_events_github_event_id_key" ON "raw_events"("github_event_id");

-- CreateIndex
CREATE INDEX "raw_events_ingestion_run_id_idx" ON "raw_events"("ingestion_run_id");

-- CreateIndex
CREATE INDEX "raw_events_repository_id_occurred_at_idx" ON "raw_events"("repository_id", "occurred_at");

-- CreateIndex
CREATE UNIQUE INDEX "repository_daily_metrics_repository_id_metric_date_key" ON "repository_daily_metrics"("repository_id", "metric_date");

-- CreateIndex
CREATE UNIQUE INDEX "repository_weekly_metrics_repository_id_week_start_date_key" ON "repository_weekly_metrics"("repository_id", "week_start_date");

-- CreateIndex
CREATE UNIQUE INDEX "keyword_daily_metrics_keyword_metric_date_key" ON "keyword_daily_metrics"("keyword", "metric_date");

-- CreateIndex
CREATE INDEX "generated_summaries_repository_id_idx" ON "generated_summaries"("repository_id");

-- CreateIndex
CREATE UNIQUE INDEX "generated_summaries_subject_type_subject_key_window_summary_key" ON "generated_summaries"("subject_type", "subject_key", "window", "summary_date");

-- CreateIndex
CREATE INDEX "ingestion_runs_status_started_at_idx" ON "ingestion_runs"("status", "started_at");

-- AddForeignKey
ALTER TABLE "raw_events" ADD CONSTRAINT "raw_events_repository_id_fkey" FOREIGN KEY ("repository_id") REFERENCES "repositories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "raw_events" ADD CONSTRAINT "raw_events_ingestion_run_id_fkey" FOREIGN KEY ("ingestion_run_id") REFERENCES "ingestion_runs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "repository_daily_metrics" ADD CONSTRAINT "repository_daily_metrics_repository_id_fkey" FOREIGN KEY ("repository_id") REFERENCES "repositories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "repository_weekly_metrics" ADD CONSTRAINT "repository_weekly_metrics_repository_id_fkey" FOREIGN KEY ("repository_id") REFERENCES "repositories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "generated_summaries" ADD CONSTRAINT "generated_summaries_repository_id_fkey" FOREIGN KEY ("repository_id") REFERENCES "repositories"("id") ON DELETE SET NULL ON UPDATE CASCADE;
