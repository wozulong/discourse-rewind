import Component from "@glimmer/component";
import { concat } from "@ember/helper";

export default class BestTopics extends Component {
  <template>
    <div class="rewind-report-page -best-topics">
      <h3 class="rewind-report-title">Your 3 best topics</h3>
      <div class="rewind-report-container">
        {{log @report.data}}
        {{#each @report.data as |topic|}}
          <div class="rewind-card">
            <a
              href={{concat "/t/-/" topic.topic_id}}
              class="best-topics__title"
            >
              {{topic.title}}
            </a>
          </div>
        {{/each}}
      </div>
    </div>
  </template>
}
