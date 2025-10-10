import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import { eq } from "truth-helpers";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import ActivityCalendar from "discourse/plugins/discourse-rewind/discourse/components/reports/activity-calendar";
import BestPosts from "discourse/plugins/discourse-rewind/discourse/components/reports/best-posts";
import BestTopics from "discourse/plugins/discourse-rewind/discourse/components/reports/best-topics";
import FavoriteCategories from "discourse/plugins/discourse-rewind/discourse/components/reports/favorite-categories";
import FavoriteTags from "discourse/plugins/discourse-rewind/discourse/components/reports/favorite-tags";
import FBFF from "discourse/plugins/discourse-rewind/discourse/components/reports/fbff";
import RewindHeader from "discourse/plugins/discourse-rewind/discourse/components/reports/header";
import Reactions from "discourse/plugins/discourse-rewind/discourse/components/reports/reactions";
import ReadingTime from "discourse/plugins/discourse-rewind/discourse/components/reports/reading-time";
import TopWords from "discourse/plugins/discourse-rewind/discourse/components/reports/top-words";

export default class Rewind extends Component {
  @tracked rewind = [];
  @tracked fullScreen = true;
  @tracked loadingRewind = false;

  @action
  registerScrollWrapper(element) {
    this.scrollWrapper = element;
  }

  @action
  async loadRewind() {
    try {
      this.loadingRewind = true;
      this.rewind = await ajax("/rewinds");
    } catch (e) {
      popupAjaxError(e);
    } finally {
      this.loadingRewind = false;
    }
  }

  @action
  toggleFullScreen() {
    this.fullScreen = !this.fullScreen;
  }

  @action
  handleEscape(event) {
    if (this.fullScreen && event.key === "Escape") {
      this.fullScreen = false;
    }
  }

  @action
  handleScroll({ target }) {
    let children = this.rewindContainer.getElementsByClassName("parallax-bg");

    for (let i = 0; i < children.length; i++) {
      children[i].style.transform = `translateY(-${
        (target.scrollTop * (i + 1)) / 5
      }px)`;
    }
  }

  @action
  registerRewindContainer(element) {
    this.rewindContainer = element;
  }

  <template>
    <div
      class={{concatClass
        "rewind-container"
        (if this.fullScreen "-fullscreen")
      }}
      {{didInsert this.loadRewind}}
      {{on "keydown" this.handleEscape}}
      {{didInsert this.registerRewindContainer}}
      tabindex="0"
    >
      <div class="rewind">
        <RewindHeader />
        <div class="background-1 parallax-bg"></div>
        {{#if this.loadingRewind}}
          <div class="rewind-loader">
            <div class="spinner small"></div>
            <div class="rewind-loader__text">Crunching your data...</div>
          </div>
        {{else}}
          <DButton
            class="rewind__exit-fullscreen-btn"
            @icon={{if this.fullScreen "discourse-compress" "discourse-expand"}}
            @action={{this.toggleFullScreen}}
          />
          <div
            class="rewind__scroll-wrapper"
            {{didInsert this.registerScrollWrapper}}
            {{on "scroll" this.handleScroll}}
          >

            {{#each this.rewind as |report|}}
              <div class={{concatClass "rewind-report" report.identifier}}>
                {{#if (eq report.identifier "fbff")}}
                  <FBFF @report={{report}} />
                {{else if (eq report.identifier "reactions")}}
                  <Reactions @report={{report}} />
                {{else if (eq report.identifier "top-words")}}
                  <TopWords @report={{report}} />
                {{else if (eq report.identifier "best-posts")}}
                  <BestPosts @report={{report}} />
                {{else if (eq report.identifier "best-topics")}}
                  <BestTopics @report={{report}} />
                {{else if (eq report.identifier "activity-calendar")}}
                  <ActivityCalendar @report={{report}} />
                {{else if (eq report.identifier "favorite-tags")}}
                  <FavoriteTags @report={{report}} />
                {{else if (eq report.identifier "reading-time")}}
                  <ReadingTime @report={{report}} />
                {{else if (eq report.identifier "favorite-categories")}}
                  <FavoriteCategories @report={{report}} />
                {{/if}}
              </div>
            {{/each}}
          </div>

          {{#if this.showPrev}}
            <DButton
              class="rewind__prev-btn"
              @icon="chevron-left"
              @action={{this.prev}}
            />
          {{/if}}

          {{#if this.showNext}}
            <DButton
              class="rewind__next-btn"
              @icon="chevron-right"
              @action={{this.next}}
            />
          {{/if}}
        {{/if}}
      </div>
    </div>
  </template>
}
