import Component from "@glimmer/component";

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class WordCloud extends Component {
  <template>
    <div class="rewind-report-page -word-cloud">
      <h3 class="rewind-report-title">Most used words</h3>
      <div class="rewind-report-container">
        {{#each-in @report.data as |word count|}}
          <div class="rewind-card">
            <span class="rewind-card__title">{{word}}</span>
            <span class="rewind-card__data">{{count}} times</span>
          </div>
        {{/each-in}}
      </div>
    </div>
  </template>
}
