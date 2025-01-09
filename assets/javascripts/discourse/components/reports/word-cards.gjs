import Component from "@glimmer/component";
import WordCard from "discourse/plugins/discourse-rewind/discourse/components/reports/word-card";

export default class WordCards extends Component {
  get topWords() {
    return this.args.report.data.sort((a, b) => b.score - a.score).slice(0, 5);
  }

  <template>
    <div class="rewind-report-page -word-cloud">
      <h2 class="rewind-report-title">Word Usage</h2>
      <div class="rewind-report-container">
        {{#each this.topWords as |entry index|}}
          <WordCard
            @word={{entry.word}}
            @count={{entry.score}}
            @index={{index}}
          />
        {{/each}}
      </div>
    </div>
  </template>
}
