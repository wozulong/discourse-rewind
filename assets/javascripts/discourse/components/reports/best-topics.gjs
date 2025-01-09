import Component from "@glimmer/component";
import { concat } from "@ember/helper";
import { htmlSafe } from "@ember/template";
import emoji from "discourse/helpers/emoji";

export default class BestTopics extends Component {
  rank(idx) {
    return idx + 1;
  }

  emojiName(rank) {
    if (rank + 1 === 1) {
      return "1st_place_medal";
    } else if (rank + 1 === 2) {
      return "2nd_place_medal";
    } else if (rank + 1 === 3) {
      return "3rd_place_medal";
    } else {
      return "medal";
    }
  }

  <template>
    <div class="rewind-report-page -best-topics">
      <h2 class="rewind-report-title">Your 3 best topics</h2>
      <div class="rewind-report-container">
        <div class="rewind-card">
          {{#each @report.data as |topic idx|}}
            <a
              href={{concat "/t/-/" topic.topic_id}}
              class={{concat "best-topics__topic" " rank-" (this.rank idx)}}
            >
              <span class="best-topics__rank">{{emoji
                  (this.emojiName idx)
                }}</span><h2>{{topic.title}}</h2>
              <span class="best-topics__excerpt">{{htmlSafe
                  topic.excerpt
                }}</span>
            </a>
          {{/each}}
        </div>
      </div>
    </div>
  </template>
}
