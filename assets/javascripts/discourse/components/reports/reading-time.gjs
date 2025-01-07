import Component from "@glimmer/component";

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ReadingTime extends Component {
  <template>
    <div class="rewind-report-page -reading-time">
      <h2 class="rewind-report-title">Reading time</h2>
      <div class="rewind-report-container">
        <span class="reading-time__time">{{@report.data.reading_time}}</span>
        <span class="reading-time__book">{{@report.data.book}}</span>
      </div>
    </div>
  </template>
}
