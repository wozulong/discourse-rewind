import Component from "@glimmer/component";
import { concat } from "@ember/helper";

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class BestTopics extends Component {
  <template>
    <div class="rewind-report-page -best-topics">
      <h2 class="rewind-report-title">Your 3 best topics</h2>
      <div class="rewind-report-container">
        {{!-- {{log @report.data}} --}}
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
