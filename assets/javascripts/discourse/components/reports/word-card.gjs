import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import emoji from "discourse/helpers/emoji";

export default class WordCard extends Component {
  get randomStyle() {
    return `--rand: ${Math.random()}`;
  }

  get mysteryEmoji() {
    const mysteryEmojis = [
      "mag", // 🔍
      "man_detective", // 🕵️
      "question", // ❓
      "8ball", // 🎱
      "crystal_ball", // 🔮
      "key", // 🗝️
      "crescent_moon", // 🌙
      "milky_way", // 🌌
    ];

    const randomIndex = Math.floor(Math.random() * mysteryEmojis.length);
    return mysteryEmojis[randomIndex];
  }

  @action
  registerCardContainer(element) {
    this.cardContainer = element;
  }

  @action
  handleClick() {
    this.cardContainer.classList.toggle("flipped");
  }

  <template>
    <div
      {{on "click" (fn this.handleClick)}}
      class="rewind-card__wrapper"
      style={{this.randomStyle}}
      {{didInsert this.registerCardContainer}}
    >
      <div class="rewind-card__inner">
        <div class="rewind-card -front">
          <span class="rewind-card__image">{{emoji this.mysteryEmoji}}</span>
        </div>
        <div class="rewind-card -back">
          <span class="rewind-card__title">{{@word}}</span>
          <span class="rewind-card__data">used {{@count}} times</span>
        </div>
      </div>
    </div>
  </template>
}
