import Component from "@glimmer/component";
import { hash } from "@ember/helper";
import avatar from "discourse/helpers/bound-avatar-template";

export default class FBFF extends Component {
  <template>
    <div class="rewind-report-page -fbff">
      <h2 class="rewind-report-title">Your FBFF (Forum Best Friend Forever)</h2>
      <div class="rewind-report-container">
        <div class="rewind-card">
          {{avatar
            @report.data.fbff.avatar_template
            "tiny"
            (hash title=@report.data.fbff.username)
          }}
          {{avatar
            @report.data.yourself.avatar_template
            "tiny"
            (hash title=@report.data.yourself.username)
          }}
        </div>
      </div>
    </div>
  </template>
}
