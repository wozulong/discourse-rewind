import Component from "@glimmer/component";
import { concat, fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import emoji from "discourse/helpers/emoji";

const MYSTERY_EMOJIS = [
  "mag", // 🔍
  "question", // ❓
  "8ball", // 🎱
  "crystal_ball", // 🔮
  "crescent_moon", // 🌙
];

const BACKGROUND_COLORS = [
  "#FBF5AF",
  "#28ABE2",
  "#F0794A",
  "#E84A51",
  "#FBF5AF",
];

export default class WordCard extends Component {
  get randomStyle() {
    return `--rand: ${Math.random()}`;
  }

  get mysteryData() {
    return {
      emoji: MYSTERY_EMOJIS[this.args.index],
      color: `--mystery-color: ${BACKGROUND_COLORS[this.args.index]}`,
    };
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
      style={{concat this.randomStyle "; " this.mysteryData.color ";"}}
      {{didInsert this.registerCardContainer}}
    >
      <div class="rewind-card__inner">
        <div class="rewind-card -front">
          <span class="rewind-card__image tl">{{emoji
              this.mysteryData.emoji
            }}</span>
          <span class="rewind-card__image cr">{{emoji
              this.mysteryData.emoji
            }}</span>
          <span class="rewind-card__image br">{{emoji
              this.mysteryData.emoji
            }}</span>
        </div>
        <div class="rewind-card -back">
          <span class="rewind-card__title">{{@word}}</span>
          <span class="rewind-card__data">used {{@count}} times</span>
        </div>
      </div>
    </div>
  </template>
}
