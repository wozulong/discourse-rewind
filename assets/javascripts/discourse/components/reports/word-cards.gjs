import Component from "@glimmer/component";
import WordCard from "discourse/plugins/discourse-rewind/discourse/components/reports/word-card";

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class WordCards extends Component {
  <template>
    <div class="rewind-report-page -word-cloud">
      <h2 class="rewind-report-title">Word Usage</h2>
      <div class="rewind-report-container">
        {{#each-in @report.data as |word count|}}
          {{! can we pass in an index here? This way inside instead of random colors & images chosen, we just set them to be static }}
          <WordCard @word={{word}} @count={{count}} />
        {{/each-in}}
      </div>
    </div>
  </template>
}
