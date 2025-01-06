import Component from "@glimmer/component";
import WordCard from "discourse/plugins/discourse-rewind/discourse/components/reports/word-card";

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class WordCards extends Component {
  <template>
    <div class="rewind-report-page -word-cloud">
      <h2 class="rewind-report-title">Most used words</h2>
      <div class="rewind-report-container">
        {{#each-in @report.data as |word count|}}
          <WordCard @word={{word}} @count={{count}} />
        {{/each-in}}
      </div>
    </div>
  </template>
}
