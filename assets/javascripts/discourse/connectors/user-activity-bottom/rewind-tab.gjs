import DNavigationItem from "discourse/components/d-navigation-item";
import icon from "discourse-common/helpers/d-icon";
import { i18n } from "discourse-i18n";

const RewindTab = <template>
  <DNavigationItem
    @route="userActivity.rewind"
    @ariaCurrentContext="subNav"
    class="user-nav__activity-rewind"
  >
    {{icon "repeat"}}
    <span>{{i18n "discourse_rewind.title"}}</span>
  </DNavigationItem>
</template>;

export default RewindTab;
