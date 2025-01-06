import Component from "@glimmer/component";
import { get } from "@ember/object";
import { htmlSafe } from "@ember/template";
import dIcon from "discourse-common/helpers/d-icon";

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class BestPosts extends Component {
  <template>
    <div class="rewind-report-page -best-posts">
      <h2 class="rewind-report-title">Your 3 best posts</h2>
      <div class="rewind-report-container">
        {{log @report.data}}
        {{#each @report.data as |post|}}
          <div class="rewind-card">
            <div class="best-posts__post">{{htmlSafe (get post "5")}}</div>
            <div class="best-posts__metadata">
              <span class="best-posts__likes">
                {{dIcon "heart"}}{{htmlSafe (get post "2")}}</span>
              <span class="best-posts__replies">
                {{dIcon "comment"}}{{htmlSafe (get post "3")}}</span>
              <a href="/t/{{get post '1'}}/{{get post '0'}}">View post</a>
            </div>
          </div>
        {{/each}}
      </div>
    </div>
  </template>
}
