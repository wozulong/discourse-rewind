import Component from "@glimmer/component";
import { service } from "@ember/service";
import dIcon from "discourse-common/helpers/d-icon";

export default class Rewind extends Component {
  @service siteSettings;

  <template>
    <div class="rewind__introduction">
      <img
        class="rewind-logo-light"
        src="/plugins/discourse-rewind/images/discourse-rewind-logo.png"
      />
      <img
        class="rewind-logo-dark"
        src="/plugins/discourse-rewind/images/discourse-rewind-logo-dark.png"
      />

    </div>
  </template>
}
