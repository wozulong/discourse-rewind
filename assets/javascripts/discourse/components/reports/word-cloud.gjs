import Component from "@glimmer/component";

export default class WordCloud extends Component {
  get randomStyle() {
    return `--rand: ${Math.random()}`;
  }

  <template>
    <div class="rewind-report-page -word-cloud">
      <h2 class="rewind-report-title">Most used words</h2>
      <div class="rewind-report-container">
        {{#each-in @report.data as |word count|}}
          <div class="rewind-card__wrapper" style={{this.randomStyle}}>
            <div class="rewind-card__inner">
              <div class="rewind-card -front">
                <span class="rewind-card__title">?</span>
                <span class="rewind-card__data">{{count}}x</span>
              </div>
              <div class="rewind-card -back">
                <span class="rewind-card__title">{{word}}</span>
                <span class="rewind-card__data">used {{count}} times</span>
              </div>
            </div>
          </div>
        {{/each-in}}
      </div>
    </div>
  </template>
}
