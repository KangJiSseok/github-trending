import { z } from "zod";

export const trendWindows = ["daily", "weekly"] as const;
export const trendWindowSchema = z.enum(trendWindows);

export const productTimezone = "Asia/Seoul" as const;
export const timezoneSchema = z.literal(productTimezone);

export const supportedEventTypes = [
  "WatchEvent",
  "ForkEvent",
  "IssuesEvent",
  "PullRequestEvent",
  "PullRequestReviewCommentEvent",
  "PushEvent",
  "CreateEvent"
] as const;

export const supportedEventTypeSchema = z.enum(supportedEventTypes);

export type TrendWindow = z.infer<typeof trendWindowSchema>;
export type SupportedEventType = z.infer<typeof supportedEventTypeSchema>;
export type ProductTimezone = z.infer<typeof timezoneSchema>;
