import { describe, expect, it } from "vitest";
import {
  supportedEventTypeSchema,
  supportedEventTypes,
  timezoneSchema,
  trendWindowSchema
} from "./trends";

describe("trend config", () => {
  it("accepts supported trend windows", () => {
    expect(trendWindowSchema.parse("daily")).toBe("daily");
    expect(trendWindowSchema.parse("weekly")).toBe("weekly");
  });

  it("accepts the shared timezone", () => {
    expect(timezoneSchema.parse("Asia/Seoul")).toBe("Asia/Seoul");
  });

  it("accepts the supported event types", () => {
    for (const eventType of supportedEventTypes) {
      expect(supportedEventTypeSchema.parse(eventType)).toBe(eventType);
    }
  });

  it("rejects unsupported event types", () => {
    expect(() => supportedEventTypeSchema.parse("ReleaseEvent")).toThrow();
  });
});
