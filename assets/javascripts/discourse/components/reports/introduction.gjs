import Component from "@glimmer/component";
import { service } from "@ember/service";

export default class Rewind extends Component {
  @service siteSettings;

  <template>
    <div class="rewind-report-page">
      <h1>{{this.siteSettings.title}} 2024 rewind</h1>
    </div>
  </template>
}
