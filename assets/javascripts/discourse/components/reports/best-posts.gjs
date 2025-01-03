import Component from "@glimmer/component";
import { get } from "@ember/object";
import { htmlSafe } from "@ember/template";

export default class BestPosts extends Component {
  <template>
    <div class="rewind-report-page -best-posts">
      <h3 class="rewind-report-title">Your 3 best posts</h3>
      <div class="rewind-report-container">
        {{#each @report.data as |post|}}
          <div class="rewind-card">
            <div class="best-posts__post">{{htmlSafe (get post "5")}}</div>
            <span class="best-posts__likes">Likes:
              {{htmlSafe (get post "2")}}</span>
            <span class="best-posts__replies">Replies:
              {{htmlSafe (get post "3")}}</span>
          </div>
        {{/each}}
      </div>
    </div>
  </template>
}
