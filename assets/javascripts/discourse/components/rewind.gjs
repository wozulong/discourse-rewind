import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import { eq } from "truth-helpers";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import Reactions from "discourse/plugins/discourse-rewind/discourse/components/reports/reactions";

export default class Rewind extends Component {
  @tracked rewind = [];

  @tracked fullScreen = true;

  @action
  async loadRewind() {
    try {
      this.rewind = await ajax("/rewinds");
    } catch (e) {
      popupAjaxError(e);
    }
  }

  @action
  toggleFullScreen() {
    this.fullScreen = !this.fullScreen;
  }

  reportComponentForIdentifier(identifier) {
    if (identifier === "reactions") {
      return Reactions;
    }
  }

  <template>
    <div
      class={{concatClass "rewind" (if this.fullScreen "-fullscreen")}}
      {{didInsert this.loadRewind}}
    >
      <DButton
        class="rewind__exit-fullscreen-btn"
        @icon={{if this.fullScreen "discourse-compress" "discourse-expand"}}
        title="Toggle fullscreen"
        @action={{this.toggleFullScreen}}
      />
      {{#each this.rewind as |report|}}
        {{#if (eq report.identifier "reactions")}}
          <div class="rewind-report">
            <Reactions @report={{report}} />
          </div>
        {{/if}}
      {{/each}}
    </div>
  </template>
}
