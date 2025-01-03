import Component from "@glimmer/component";
import { concat } from "@ember/helper";

export default class FavoriteCategories extends Component {
  <template>
    <div class="rewind-report-page -favorite-categories">
      <h3 class="rewind-report-title">Your favorite categories</h3>
      <div class="rewind-report-container">
        {{#each @report.data as |data|}}
          <div class="rewind-card">
            <a href={{concat "/c/-/" data.category_id}}>{{data.name}}</a>
          </div>
        {{/each}}
      </div>
    </div>
  </template>
}
