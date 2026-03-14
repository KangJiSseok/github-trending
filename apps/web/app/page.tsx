import { productTimezone } from "@repo/config";

const placeholderSections = [
  {
    title: "KST Daily Briefing",
    description: "오늘의 GitHub 변화 신호를 KST 기준으로 빠르게 읽을 수 있는 일간 브리핑 영역입니다."
  },
  {
    title: "Weekly Report",
    description: "최근 7일 동안 이어진 기술 및 저장소 흐름을 정리할 주간 리포트 영역입니다."
  },
  {
    title: "Repository Trends",
    description: "급상승 저장소 카드와 주요 변화 이유가 들어갈 영역입니다."
  },
  {
    title: "Methodology",
    description: "데이터 출처, 갱신 주기, 한계를 설명할 방법론 영역입니다."
  }
];

export default function HomePage() {
  return (
    <main className="page-shell">
      <section className="hero">
        <p className="eyebrow">KST trend briefing workspace</p>
        <h1>GitHub Trend Radar KR</h1>
        <p className="hero-copy">
          한국 사용자를 위한 GitHub 트렌드 해석 레이어를 준비 중입니다.
        </p>
        <div className="meta-chip">{productTimezone}</div>
      </section>

      <section className="grid" aria-label="placeholder sections">
        {placeholderSections.map((section) => (
          <article className="card" key={section.title}>
            <h2>{section.title}</h2>
            <p>{section.description}</p>
          </article>
        ))}
      </section>
    </main>
  );
}
