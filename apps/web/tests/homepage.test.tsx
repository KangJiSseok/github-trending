import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import HomePage from "../app/page";

describe("HomePage", () => {
  it("renders the GIT-1 placeholder shell", () => {
    render(<HomePage />);

    expect(screen.getByText("GitHub Trend Radar KR")).toBeInTheDocument();
    expect(screen.getByText("KST Daily Briefing")).toBeInTheDocument();
    expect(screen.getByText("Weekly Report")).toBeInTheDocument();
    expect(screen.getByText("Asia/Seoul")).toBeInTheDocument();
    expect(screen.getByText("Repository Trends")).toBeInTheDocument();
    expect(screen.getByText("Methodology")).toBeInTheDocument();
  });
});
