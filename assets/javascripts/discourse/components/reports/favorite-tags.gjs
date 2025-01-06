import Component from "@glimmer/component";
import { concat } from "@ember/helper";

export default class FavoriteTags extends Component {
  <template>
    <div class="rewind-report-page -favorite-tags">
      <h2 class="rewind-report-title">Your favorite tags</h2>
      <div class="rewind-report-container">
        {{#each @report.data as |data|}}
          <div class="rewind-card">
            <a href={{concat "/tag/-/" data.name}}>{{data.name}}</a>
          </div>
        {{/each}}
      </div>
    </div>
  </template>
}
