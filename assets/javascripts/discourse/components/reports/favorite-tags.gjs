import { concat } from "@ember/helper";
import { i18n } from "discourse-i18n";

const FavoriteTags = <template>
  {{#if @report.data.length}}
    <div class="rewind-report-page -favorite-tags">
      <h2 class="rewind-report-title">{{i18n
          "discourse_rewind.reports.favorite_categories.title"
          count=@report.data.length
        }}</h2>
      <div class="rewind-report-container">
        {{#each @report.data as |data|}}
          <div class="rewind-card">
            <a href={{concat "/tag/-/" data.name}}>{{data.name}}</a>
          </div>
        {{/each}}
      </div>
    </div>
  {{/if}}
</template>;

export default FavoriteTags;
